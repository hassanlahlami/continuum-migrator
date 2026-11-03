package com.continuum.migrator;

import java.util.List;
import java.util.Map;
import java.util.regex.Pattern;
import org.flywaydb.core.Flyway;
import org.flywaydb.core.api.output.MigrateResult;

/**
 * Runner Flyway du {@code continuum-migrator} (plan §4.3.5, D33).
 *
 * <p>Sélectionne le jeu de scripts selon le dialecte : les scripts communs ({@code db/common}) plus
 * les variantes du dialecte ({@code db/postgresql} ou {@code db/oracle}, D4). Migrations
 * <strong>forward-only</strong> (Flyway Community).
 *
 * <p><strong>PostgreSQL</strong> : une passe unique (le compte possède les schémas {@code platform} et
 * entité). <strong>Oracle</strong> (schéma = utilisateur, ADR 0012 / D39) : deux passes, chacune sous
 * le compte propriétaire de son schéma — {@code platform} sous {@code PLATFORM} (qui accorde ensuite
 * {@code SELECT, REFERENCES} table par table à l'entité), puis l'entité sous son propre compte. Aucun
 * privilège {@code ANY}.
 */
public final class FlywayMigrator {

    /** Nom d'utilisateur Oracle non quoté (injecté dans un GRANT dynamique : validé strictement). */
    private static final Pattern ORACLE_IDENTIFIER = Pattern.compile("[A-Za-z][A-Za-z0-9_$#]{0,127}");

    private FlywayMigrator() {
    }

    /** Configure la passe unique d'un dialecte à compte unique ({@code postgresql}). */
    public static Flyway configure(String dialect, String url, String user, String password) {
        return Flyway.configure()
                .dataSource(url, user, password)
                .locations("classpath:db/common", "classpath:db/" + dialect)
                .load();
    }

    /** Passe {@code platform} Oracle sans compte applicatif plateforme. */
    public static Flyway configureOraclePlatform(String url, String platformUser, String platformPassword,
            String entityUser) {
        return configureOraclePlatform(url, platformUser, platformPassword, entityUser, null);
    }

    /**
     * Passe {@code platform} Oracle, sous le propriétaire du schéma partagé ; accorde la lecture à
     * {@code entityUser} et le DML des tables écrites à l'exécution à {@code platformAppUser} (compte sans
     * DDL, ADR 0012 amendé ; {@code null}/vide = aucun).
     */
    public static Flyway configureOraclePlatform(String url, String platformUser, String platformPassword,
            String entityUser, String platformAppUser) {
        String appUser = platformAppUser == null ? "" : platformAppUser;
        if (!appUser.isEmpty() && !ORACLE_IDENTIFIER.matcher(appUser).matches()) {
            throw new IllegalArgumentException("Utilisateur Oracle plateforme invalide : " + appUser);
        }
        if (entityUser == null || !ORACLE_IDENTIFIER.matcher(entityUser).matches()) {
            throw new IllegalArgumentException("Utilisateur Oracle d'entité invalide : " + entityUser);
        }
        return Flyway.configure()
                .dataSource(url, platformUser, platformPassword)
                .locations("classpath:db/common/platform", "classpath:db/oracle/platform")
                .placeholders(Map.of("entityUser", entityUser, "platformAppUser", appUser))
                .load();
    }

    /**
     * Garde-fou : une exécution Oracle sans compte applicatif plateforme laisse ce compte sans aucun grant
     * (dérive constatée le 2026-11-03). Échoue sauf opt-out explicite ({@code allowNone}).
     */
    public static void requirePlatformAppUser(String dialect, String platformAppUser, boolean allowNone) {
        if ("oracle".equals(dialect) && (platformAppUser == null || platformAppUser.isBlank()) && !allowNone) {
            throw new IllegalArgumentException("Oracle : platformAppUser vide, PLATFORM_APP n'aurait aucun grant "
                    + "(ADR 0012 §Décision 5). Passer -Ddb.platform.app.user=PLATFORM_APP, ou "
                    + "-Ddb.platform.app.user.none=true pour l'omettre volontairement.");
        }
    }

    /** Passe entité Oracle, sous le propriétaire du schéma de l'entité. */
    public static Flyway configureOracleEntity(String url, String entityUser, String entityPassword) {
        return Flyway.configure()
                .dataSource(url, entityUser, entityPassword)
                .locations("classpath:db/common/entity", "classpath:db/oracle/entity")
                .load();
    }

    /**
     * Passes à exécuter, dans l'ordre. {@code user}/{@code password} = compte de l'entité (ou compte
     * unique en PostgreSQL) ; {@code platformUser}/{@code platformPassword} ne servent qu'à Oracle.
     */
    public static List<Flyway> passes(String dialect, String url, String user, String password,
            String platformUser, String platformPassword) {
        return passes(dialect, url, user, password, platformUser, platformPassword, null);
    }

    /** Idem, avec le compte applicatif plateforme sans DDL ({@code platformAppUser}, Oracle). */
    public static List<Flyway> passes(String dialect, String url, String user, String password,
            String platformUser, String platformPassword, String platformAppUser) {
        if (!"oracle".equals(dialect)) {
            return List.of(configure(dialect, url, user, password));
        }
        return List.of(
                configureOraclePlatform(url, platformUser, platformPassword, user, platformAppUser),
                configureOracleEntity(url, user, password));
    }

    /** Applique les migrations en attente (passe unique) et renvoie le résultat. */
    public static MigrateResult migrate(String dialect, String url, String user, String password) {
        return configure(dialect, url, user, password).migrate();
    }

    /** Applique les deux passes Oracle (platform puis entité) ; renvoie les résultats dans cet ordre. */
    public static List<MigrateResult> migrateOracle(String url, String platformUser, String platformPassword,
            String entityUser, String entityPassword) {
        return passes("oracle", url, entityUser, entityPassword, platformUser, platformPassword).stream()
                .map(Flyway::migrate)
                .toList();
    }
}

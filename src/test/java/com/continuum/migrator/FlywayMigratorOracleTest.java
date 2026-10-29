package com.continuum.migrator;

import static org.assertj.core.api.Assertions.assertThat;
import static org.assertj.core.api.Assertions.assertThatThrownBy;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.List;
import org.flywaydb.core.api.output.MigrateResult;
import org.junit.jupiter.api.Assumptions;
import org.junit.jupiter.api.BeforeAll;
import org.junit.jupiter.api.Test;

/**
 * Parité Oracle de {@link FlywayMigratorTest} (ADR 0012, D39) : les deux passes (platform sous
 * {@code PLATFORM}, entité sous son propriétaire) s'appliquent sur un Oracle réel, sans privilège
 * {@code ANY}, et l'entité lit/référence le schéma partagé uniquement par GRANT. Base fournie via
 * {@code -Dit.oracle.url}, {@code -Dit.oracle.user/password} (entité) et
 * {@code -Dit.oracle.platform.user/password} (sinon test neutralisé).
 */
class FlywayMigratorOracleTest {

    private static String url;
    private static String entityUser;
    private static String entityPassword;
    private static String platformUser;
    private static String platformPassword;

    @BeforeAll
    static void reset() throws SQLException {
        url = System.getProperty("it.oracle.url");
        Assumptions.assumeTrue(url != null && !url.isBlank() && !url.startsWith("${"),
                "Base Oracle absente : lancer avec -Dit.oracle.url=… -Dit.oracle.user=… -Dit.oracle.password=… "
                        + "-Dit.oracle.platform.user=… -Dit.oracle.platform.password=…");
        entityUser = System.getProperty("it.oracle.user");
        entityPassword = System.getProperty("it.oracle.password");
        platformUser = System.getProperty("it.oracle.platform.user");
        platformPassword = System.getProperty("it.oracle.platform.password");

        // Schémas persistants entre exécutions : on vide l'entité d'abord (FK vers platform), puis platform.
        dropAllTables(entityUser, entityPassword);
        dropAllTables(platformUser, platformPassword);
    }

    @Test
    void migrateAppliesBothOraclePassesUnderSchemaOwners() throws SQLException {
        List<MigrateResult> results =
                migrate();

        assertThat(results).hasSize(2).allMatch(r -> r.success);
        assertThat(results.get(0).migrationsExecuted).isGreaterThanOrEqualTo(3); // 2 versionnées + catalogue
        assertThat(results.get(1).migrationsExecuted).isGreaterThanOrEqualTo(9);

        // Lecture cross-schema par GRANT SELECT (catalogue peuplé par la passe platform).
        assertThat(count("SELECT count(*) FROM platform.feature")).isEqualTo(119);
        assertThat(count("SELECT count(*) FROM platform.tenant")).isZero();
        assertThat(count("SELECT count(*) FROM org_unit")).isZero();
        assertThat(count("SELECT count(*) FROM audit_event")).isZero();
        // Clé étrangère entité → platform.feature (GRANT REFERENCES).
        assertThat(count("SELECT count(*) FROM user_constraints WHERE constraint_name = 'FK_RF_FEATURE' "
                + "AND r_owner = '" + platformUser.toUpperCase() + "'")).isEqualTo(1);
        // Moindre privilège : l'entité ne peut pas écrire dans le schéma partagé.
        assertThatThrownBy(() -> execAsEntity(
                "INSERT INTO platform.feature (code, module, label_key) VALUES ('x.y', 'X', 'x')"))
                .isInstanceOf(SQLException.class);

        // directory_sync_state : table présente, écriture d'état permise à l'entité (INSERT/UPDATE ciblés).
        assertThat(count("SELECT count(*) FROM platform.directory_sync_state")).isZero();
        assertThat(count("SELECT count(*) FROM all_tab_privs WHERE grantee = '" + entityUser.toUpperCase()
                + "' AND table_name = 'DIRECTORY_SYNC_STATE' AND privilege = 'UPDATE'")).isEqualTo(1);

        // alert_rule : lecture seule pour l'entité (ADR 0012 amendé), DML réservé au compte applicatif plateforme.
        assertThat(count("SELECT count(*) FROM platform.alert_rule")).isZero();
        assertThat(count("SELECT count(*) FROM all_tab_privs WHERE grantee = '" + entityUser.toUpperCase()
                + "' AND table_name LIKE 'ALERT_RULE%' AND privilege IN ('INSERT', 'UPDATE', 'DELETE')")).isZero();
        String appUser = System.getProperty("it.oracle.platform.app.user");
        if (appUser != null && !appUser.isBlank()) {
            try (Connection c = DriverManager.getConnection(url, platformUser, platformPassword);
                    Statement st = c.createStatement();
                    ResultSet rs = st.executeQuery("SELECT count(*) FROM user_tab_privs_made WHERE grantee = '"
                            + appUser.toUpperCase() + "' AND table_name LIKE 'ALERT_RULE%' "
                            + "AND privilege IN ('SELECT', 'INSERT', 'UPDATE', 'DELETE')")) {
                rs.next();
                assertThat(rs.getLong(1)).isEqualTo(8);
            }
        }

        // Rejouable : rien à appliquer, les GRANT du callback sont idempotents.
        List<MigrateResult> again =
                migrate();
        assertThat(again).allMatch(r -> r.success && r.migrationsExecuted == 0);
    }

    private static List<MigrateResult> migrate() {
        String appUser = System.getProperty("it.oracle.platform.app.user");
        return FlywayMigrator.passes("oracle", url, entityUser, entityPassword, platformUser, platformPassword, appUser)
                .stream().map(org.flywaydb.core.Flyway::migrate).toList();
    }

    private static void dropAllTables(String user, String password) throws SQLException {
        try (Connection c = DriverManager.getConnection(url, user, password); Statement s = c.createStatement()) {
            s.execute("""
                    BEGIN
                      FOR t IN (SELECT table_name FROM user_tables) LOOP
                        EXECUTE IMMEDIATE 'DROP TABLE "' || t.table_name || '" CASCADE CONSTRAINTS PURGE';
                      END LOOP;
                    END;""");
        }
    }

    private static void execAsEntity(String sql) throws SQLException {
        try (Connection c = DriverManager.getConnection(url, entityUser, entityPassword);
                Statement s = c.createStatement()) {
            s.execute(sql);
        }
    }

    private static long count(String sql) throws SQLException {
        try (Connection c = DriverManager.getConnection(url, entityUser, entityPassword);
                Statement s = c.createStatement();
                ResultSet rs = s.executeQuery(sql)) {
            rs.next();
            return rs.getLong(1);
        }
    }
}

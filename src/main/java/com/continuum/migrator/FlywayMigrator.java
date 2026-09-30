package com.continuum.migrator;

import org.flywaydb.core.Flyway;
import org.flywaydb.core.api.output.MigrateResult;

/**
 * Runner Flyway du {@code continuum-migrator} (plan §4.3.5, D33).
 *
 * <p>Sélectionne le jeu de scripts selon le dialecte : les scripts communs ({@code db/common}) plus
 * les variantes du dialecte ({@code db/postgresql} ou {@code db/oracle}, D4). Migrations
 * <strong>forward-only</strong> (Flyway Community).
 */
public final class FlywayMigrator {

    private FlywayMigrator() {
    }

    /** Configure Flyway pour un dialecte donné ({@code postgresql} | {@code oracle}). */
    public static Flyway configure(String dialect, String url, String user, String password) {
        return Flyway.configure()
                .dataSource(url, user, password)
                .locations("classpath:db/common", "classpath:db/" + dialect)
                .load();
    }

    /** Applique les migrations en attente et renvoie le résultat. */
    public static MigrateResult migrate(String dialect, String url, String user, String password) {
        return configure(dialect, url, user, password).migrate();
    }
}

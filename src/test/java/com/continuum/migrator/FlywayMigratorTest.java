package com.continuum.migrator;

import static org.assertj.core.api.Assertions.assertThat;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import org.flywaydb.core.api.output.MigrateResult;
import org.junit.jupiter.api.Assumptions;
import org.junit.jupiter.api.BeforeAll;
import org.junit.jupiter.api.Test;

/**
 * Vérifie que le runner Flyway applique toute la chaîne de migrations PostgreSQL sur une base réelle
 * (plan §4.3.5). Base fournie via {@code -Dit.db.url} (sinon test neutralisé). JDBC nu — le migrateur
 * ne dépend que de Flyway.
 */
class FlywayMigratorTest {

    private static String url;
    private static String user;
    private static String password;

    @BeforeAll
    static void reset() throws SQLException {
        url = System.getProperty("it.db.url");
        Assumptions.assumeTrue(url != null && !url.isBlank() && !url.startsWith("${"),
                "Base de test absente : lancer avec -Dit.db.url=… -Dit.db.user=… -Dit.db.password=…");
        user = System.getProperty("it.db.user");
        password = System.getProperty("it.db.password");

        try (Connection c = DriverManager.getConnection(url, user, password); Statement s = c.createStatement()) {
            s.execute("DROP SCHEMA IF EXISTS platform CASCADE");
            s.execute("DROP SCHEMA public CASCADE");
            s.execute("CREATE SCHEMA public");
        }
    }

    @Test
    void migrateAppliesAllPostgresScripts() throws SQLException {
        MigrateResult result = FlywayMigrator.migrate("postgresql", url, user, password);

        assertThat(result.success).isTrue();
        assertThat(result.migrationsExecuted).isGreaterThanOrEqualTo(3);
        assertThat(count("SELECT count(*) FROM platform.feature")).isEqualTo(119);
        // Tables créées par les migrations d'entité et d'audit (présence = 0 ligne, pas d'erreur).
        assertThat(count("SELECT count(*) FROM org_unit")).isZero();
        assertThat(count("SELECT count(*) FROM audit_event")).isZero();
    }

    private static long count(String sql) throws SQLException {
        try (Connection c = DriverManager.getConnection(url, user, password);
                Statement s = c.createStatement();
                ResultSet rs = s.executeQuery(sql)) {
            rs.next();
            return rs.getLong(1);
        }
    }
}

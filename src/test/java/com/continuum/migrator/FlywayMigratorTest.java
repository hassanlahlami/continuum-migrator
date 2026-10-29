package com.continuum.migrator;

import static org.assertj.core.api.Assertions.assertThat;
import static org.assertj.core.api.Assertions.assertThatThrownBy;

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

    @Test
    void directorySyncStateEnforcesUniqueSourceAndStatus() throws SQLException {
        FlywayMigrator.migrate("postgresql", url, user, password);
        try (Connection c = DriverManager.getConnection(url, user, password); Statement s = c.createStatement()) {
            s.execute("INSERT INTO platform.tenant (id, code, label) VALUES "
                    + "('11111111-1111-1111-1111-1111111111aa', 'dss', 'DSS')");
            s.execute("INSERT INTO platform.directory_sync_state (id, tenant_id, source_code) VALUES "
                    + "('33333333-3333-3333-3333-3333333333aa', '11111111-1111-1111-1111-1111111111aa', 'AD')");
            assertThat(count("SELECT count(*) FROM platform.directory_sync_state WHERE status = 'NEVER' AND version = 0"))
                    .isEqualTo(1);
            assertThatThrownBy(() -> s.execute("INSERT INTO platform.directory_sync_state (id, tenant_id, source_code) "
                    + "VALUES ('33333333-3333-3333-3333-3333333333ab', '11111111-1111-1111-1111-1111111111aa', 'AD')"))
                    .isInstanceOf(SQLException.class);
            assertThatThrownBy(() -> s.execute("INSERT INTO platform.directory_sync_state (id, tenant_id, source_code, status) "
                    + "VALUES ('33333333-3333-3333-3333-3333333333ac', '11111111-1111-1111-1111-1111111111aa', 'X', 'BAD')"))
                    .isInstanceOf(SQLException.class);
        }
    }

    @Test
    void alertRuleStoresChannelsAsChildRowsAndCascadesOnDelete() throws SQLException {
        FlywayMigrator.migrate("postgresql", url, user, password);
        try (Connection c = DriverManager.getConnection(url, user, password); Statement s = c.createStatement()) {
            s.execute("INSERT INTO platform.alert_rule (id, label, event_code, threshold, window_iso) VALUES "
                    + "('44444444-4444-4444-4444-4444444444aa', 'CBS indisponible', 'CTN-INT-0102', 5, 'PT10M')");
            assertThat(count("SELECT count(*) FROM platform.alert_rule WHERE enabled AND version = 0")).isEqualTo(1);
            s.execute("INSERT INTO platform.alert_rule_channel (alert_rule_id, channel) VALUES "
                    + "('44444444-4444-4444-4444-4444444444aa', 'IN_APP'), "
                    + "('44444444-4444-4444-4444-4444444444aa', 'SIEM')");
            assertThatThrownBy(() -> s.execute("INSERT INTO platform.alert_rule_channel (alert_rule_id, channel) "
                    + "VALUES ('44444444-4444-4444-4444-4444444444aa', 'SMS')"))
                    .isInstanceOf(SQLException.class);
            s.execute("DELETE FROM platform.alert_rule WHERE id = '44444444-4444-4444-4444-4444444444aa'");
            assertThat(count("SELECT count(*) FROM platform.alert_rule_channel")).isZero();
        }
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

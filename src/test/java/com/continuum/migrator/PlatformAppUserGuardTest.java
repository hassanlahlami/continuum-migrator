package com.continuum.migrator;

import static org.assertj.core.api.Assertions.assertThatCode;
import static org.assertj.core.api.Assertions.assertThatThrownBy;

import org.junit.jupiter.api.Test;

class PlatformAppUserGuardTest {

    @Test
    void oracleWithoutAppUserFailsLoudly() {
        assertThatThrownBy(() -> FlywayMigrator.requirePlatformAppUser("oracle", "", false))
                .isInstanceOf(IllegalArgumentException.class).hasMessageContaining("PLATFORM_APP");
        assertThatThrownBy(() -> FlywayMigrator.requirePlatformAppUser("oracle", null, false))
                .isInstanceOf(IllegalArgumentException.class);
    }

    @Test
    void allowedWhenProvidedOptedOutOrPostgres() {
        assertThatCode(() -> FlywayMigrator.requirePlatformAppUser("oracle", "PLATFORM_APP", false)).doesNotThrowAnyException();
        assertThatCode(() -> FlywayMigrator.requirePlatformAppUser("oracle", "", true)).doesNotThrowAnyException();
        assertThatCode(() -> FlywayMigrator.requirePlatformAppUser("postgresql", null, false)).doesNotThrowAnyException();
    }
}

package com.continuum.migrator;

import static org.assertj.core.api.Assertions.assertThat;

import java.io.IOException;
import java.nio.file.Files;
import java.nio.file.Path;
import java.util.Set;
import java.util.TreeSet;
import java.util.stream.Stream;
import org.junit.jupiter.api.Test;

/**
 * Parité stricte des dialectes (D4) : chaque script PostgreSQL a son pendant Oracle, de même nom,
 * quelle que soit la passe Oracle qui le porte ({@code platform/} ou {@code entity/}, ADR 0012).
 */
class DialectParityTest {

    private static final Path DB = Path.of("src", "main", "resources", "db");

    @Test
    void everyMigrationExistsInBothDialects() throws IOException {
        assertThat(scripts(DB.resolve("oracle"))).isEqualTo(scripts(DB.resolve("postgresql")));
    }

    private static Set<String> scripts(Path root) throws IOException {
        try (Stream<Path> files = Files.walk(root)) {
            return files.map(p -> p.getFileName().toString())
                    .filter(n -> n.matches("[VR]\\d*__.+\\.sql"))
                    // Oracle counterpart = grants in afterMigrate__grant_entity_access.sql (platform pass)
                    .filter(n -> !n.equals("R__grant_schema_history_read.sql"))
                    .collect(TreeSet::new, Set::add, Set::addAll);
        }
    }
}

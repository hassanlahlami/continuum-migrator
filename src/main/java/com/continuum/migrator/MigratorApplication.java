package com.continuum.migrator;

import java.util.List;
import org.flywaydb.core.Flyway;
import org.flywaydb.core.api.MigrationInfo;

/**
 * Service de migration séparé (D33, plan §4.3.5), exécuté AVANT le backend puis terminé.
 *
 * <p>CLI : {@code migrate} | {@code info} | {@code validate}. Paramètres par propriétés système :
 * {@code -Ddb.dialect=postgresql|oracle -Ddb.url=… -Ddb.user=… -Ddb.password=…}. En Oracle (ADR 0012),
 * {@code db.user} est le compte de l'entité et {@code -Ddb.platform.user=… -Ddb.platform.password=…} le
 * propriétaire du schéma partagé (et {@code -Ddb.platform.app.user=…} le compte applicatif plateforme sans DDL
 * qui reçoit le DML des tables écrites à l'exécution) : deux passes (platform puis entité). Codes de sortie
 * explicites (0 = à jour/migré, 1 = échec) pour l'intégration dans les chaînes de déploiement.
 *
 * <p>Le jeu de données de démonstration ({@code seed --dataset=demo}, §8.7) et les autres commandes
 * seront ajoutés ensuite.
 */
public final class MigratorApplication {

    private MigratorApplication() {
    }

    public static void main(String[] args) {
        String command = args.length > 0 ? args[0] : "info";
        String dialect = System.getProperty("db.dialect", "postgresql");
        if (!List.of("migrate", "validate", "info").contains(command)) {
            System.err.println("Commande inconnue : " + command + " (migrate | info | validate)");
            System.exit(2);
        }
        try {
            List<Flyway> passes = FlywayMigrator.passes(
                    dialect,
                    System.getProperty("db.url"),
                    System.getProperty("db.user"),
                    System.getProperty("db.password"),
                    System.getProperty("db.platform.user"),
                    System.getProperty("db.platform.password"),
                    System.getProperty("db.platform.app.user"));
            for (Flyway flyway : passes) {
                switch (command) {
                    case "migrate" -> {
                        int applied = flyway.migrate().migrationsExecuted;
                        System.out.println("Migrations appliquées : " + applied);
                    }
                    case "validate" -> flyway.validate();
                    default -> {
                        for (MigrationInfo mi : flyway.info().all()) {
                            System.out.printf("%-22s %-10s %s%n", mi.getVersion(), mi.getState(), mi.getDescription());
                        }
                    }
                }
            }
        } catch (RuntimeException e) {
            System.err.println("Échec de migration : " + e.getMessage());
            System.exit(1);
        }
    }
}

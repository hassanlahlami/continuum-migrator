package com.continuum.migrator;

import org.springframework.boot.SpringApplication;
import org.springframework.boot.autoconfigure.SpringBootApplication;

/**
 * Service de migration separe (D33, plan §4.3.5).
 *
 * <p>Execute AVANT le backend, puis se termine. Il embarque Flyway et tous les
 * scripts (mode hors-ligne, D26). Commandes prevues : {@code info}, {@code validate},
 * {@code migrate}, {@code baseline}, {@code repair}, {@code version},
 * {@code seed --dataset=demo} (refuse hors profil {@code demo}/{@code test}, §8.7).
 *
 * <p>Migrations <strong>forward-only</strong> (Flyway Community : pas d'{@code undo}).
 * Le retour arriere passe par la restauration de sauvegarde (§11.7).
 */
@SpringBootApplication
public class MigratorApplication {

    public static void main(String[] args) {
        SpringApplication.run(MigratorApplication.class, args);
    }
}

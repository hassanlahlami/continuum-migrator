# continuum-migrator

Migrateur de schéma de Continuum (plan §4.3.5, D33). Application **Flyway** autonome qui applique les
migrations **avant** le backend — le backend ne migre jamais la base, il la *vérifie* au démarrage.

## Principe

- Migrations **forward-only** (Flyway Community — pas d'`undo`, cf. Q12).
- Scripts par dialecte (D4) : `src/main/resources/db/common` + `db/postgresql` **ou** `db/oracle`,
  sélectionnés par l'argument `-Ddb.dialect`.
- Nommage `Vyyyymmddhhmm__description.sql` (versionnées) et `R__*.sql` (répétables, ex. catalogue de
  fonctionnalités). La version numérique est le contrat lu par le garde-fou `CTN-DB-0003` du backend.

## Lancer

```bash
mvn -o spring-boot:run \
  -Dspring-boot.run.jvmArguments="-Ddb.url=<jdbc-url> -Ddb.user=<u> -Ddb.password=<p> -Ddb.dialect=postgresql" \
  -Dspring-boot.run.arguments=migrate
```

`-Ddb.dialect` = `postgresql` ou `oracle`. L'historique Flyway est la table `flyway_schema_history`
(schéma par défaut de la connexion).

## Tester

```bash
mvn -o surefire:test -Dtest=FlywayMigratorTest \
  -Dit.db.url=jdbc:postgresql://localhost:5432/<db> -Dit.db.user=<u> -Dit.db.password=<p>
```

Le test applique toute la chaîne sur une base PostgreSQL réelle (sinon il est neutralisé). La parité
Oracle de bout en bout dépend de la topologie des schémas Oracle (`PLATFORM` partagé) — voir
`Instructions/docs/suivi/QUESTIONS.md` Q16.

## Références

Déploiement : `../Instructions/docs/exploitation/DEPLOIEMENT.md`. Plan : §4.3.5.
Démo/seed : `src/main/resources/db/seed/` (D37).

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

**Oracle — deux passes (ADR 0012, D39)** : schéma = utilisateur. `-Ddb.user/-Ddb.password` = compte de
l'**entité** (ex. `CONTINUUM`) et `-Ddb.platform.user/-Ddb.platform.password` = propriétaire du schéma
partagé `PLATFORM`. Passe 1 sous `PLATFORM` (`db/oracle/platform/`), dont le callback
`afterMigrate__grant_entity_access.sql` accorde `SELECT, REFERENCES` table par table à l'entité ; passe 2
sous l'entité (`db/oracle/entity/`). Chaque schéma a son propre historique Flyway. Aucun privilège `ANY`.

## Tester

```bash
mvn -o surefire:test -Dtest=FlywayMigratorTest \
  -Dit.db.url=jdbc:postgresql://localhost:5432/<db> -Dit.db.user=<u> -Dit.db.password=<p>
```

Le test applique toute la chaîne sur une base PostgreSQL réelle (sinon il est neutralisé).

Parité Oracle de bout en bout (sim `gvenzl/oracle-free`, users `PLATFORM` + `CONTINUUM` provisionnés par
`Instructions/infra/simulation/oracle/init/`) :

```bash
mvn -o surefire:test -Dtest=FlywayMigratorOracleTest   -Dit.oracle.url=jdbc:oracle:thin:@localhost:1521/FREEPDB1   -Dit.oracle.user=CONTINUUM -Dit.oracle.password=<p>   -Dit.oracle.platform.user=PLATFORM -Dit.oracle.platform.password=<p>
```

`DialectParityTest` (sans base) échoue si un script n'existe pas dans les deux dialectes.

## Références

Déploiement : `../Instructions/docs/exploitation/DEPLOIEMENT.md`. Plan : §4.3.5.
Démo/seed : `src/main/resources/db/seed/` (D37).

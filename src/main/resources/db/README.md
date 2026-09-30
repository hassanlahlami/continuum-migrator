# Migrations de base — `continuum-migrator`

> Source : plan §4.3.5, décision **D33**. Service Flyway **séparé**, exécuté **avant** le backend.

## Organisation des scripts

```
db/
  common/                 scripts identiques aux deux bases (majorité)
    platform/             schéma partagé : entités, catalogue de fonctionnalités, config technique
    entity/               schéma d'une filiale : iam, metier, config, audit_trail, wf_engine
  postgresql/             variantes spécifiques (ltree, JSONB, index GiST)
  oracle/                 variantes spécifiques (table de fermeture, JSON, PDB)
  seed/demo/              jeu de données de démonstration complet (D37, §8.7)
                          — emplacement séparé, JAMAIS dans les emplacements de production
```

## Règles

- **Nommage** : `V{AAAAMMJJHHmm}__{description}.sql` (horodatage → pas de collision de numéro),
  `R__{description}.sql` pour les scripts rejouables.
- **Catalogue des fonctionnalités** : `R__feature_catalog.sql` est **généré** à partir du registre
  Java `Feature` au build. La CI échoue si le fichier commité n'est plus à jour (§2.1.7).
- **Forward-only** : Flyway Community, pas d'`undo`. Chaque script destructeur est précédé d'un
  script de sauvegarde de données.
- **Ce qui n'est PAS une migration** : les packs de conformité (référentiels, rôles, positions,
  workflows, politiques) sont des **données de paramétrage** installées par l'Admin Système (OPS-04),
  pas par Flyway. Les jeux de démonstration relèvent de `seed/demo/`.
- **Garde-fou seed** : `seed --dataset=demo` est refusé hors profil `demo`/`test`.

-- Marque d'origine pack des règles SoD (comme role.from_pack) : une règle livrée par le pack n'est pas supprimable.
ALTER TABLE sod_rule ADD COLUMN from_pack BOOLEAN NOT NULL DEFAULT FALSE;

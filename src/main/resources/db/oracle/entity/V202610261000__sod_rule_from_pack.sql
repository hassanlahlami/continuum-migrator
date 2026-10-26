-- Marque d'origine pack des règles SoD (comme role.from_pack) : une règle livrée par le pack n'est pas supprimable.
ALTER TABLE sod_rule ADD (from_pack NUMBER(1) DEFAULT 0 NOT NULL CHECK (from_pack IN (0, 1)));

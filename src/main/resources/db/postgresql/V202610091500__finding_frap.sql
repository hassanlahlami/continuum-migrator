-- Détail FRAP du constat (plan §6, contrat app/findings.yaml) — dialecte PostgreSQL.
-- Fait / Critère / Cause / Conséquence : le cœur rédactionnel d'un constat (FRAP).

ALTER TABLE finding
    ADD COLUMN fact        TEXT,
    ADD COLUMN criterion   TEXT,
    ADD COLUMN cause        TEXT,
    ADD COLUMN consequence TEXT;

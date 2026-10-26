-- Détail FRAP du constat (plan §6, contrat app/findings.yaml) — dialecte Oracle (D4).
-- Fait / Critère / Cause / Conséquence en CLOB (texte long).

ALTER TABLE finding ADD (
    fact        CLOB,
    criterion   CLOB,
    cause        CLOB,
    consequence CLOB
);

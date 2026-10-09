-- Entité Constat / Finding (plan §6, contrat app/findings.yaml) — dialecte PostgreSQL.
-- Rattaché à une mission ; scindé par l'unité auditée (finding.read, §2.1.6). Libellés de
-- référentiels (statut, criticité) inline en attendant le module de paramétrage (§1.6).

CREATE TABLE finding (
    id                 UUID PRIMARY KEY,
    tenant_id          UUID NOT NULL,
    mission_id         UUID REFERENCES mission(id),
    org_unit_id        UUID REFERENCES org_unit(id),
    reference          VARCHAR(50)  NOT NULL,
    title              VARCHAR(500) NOT NULL,
    status_code        VARCHAR(50)  NOT NULL,
    status_label       VARCHAR(200) NOT NULL,
    criticality_code   VARCHAR(50),
    criticality_label  VARCHAR(200),
    source             VARCHAR(20)  NOT NULL DEFAULT 'MANUAL',
    created_at         TIMESTAMPTZ NOT NULL DEFAULT now(),
    version            INTEGER NOT NULL DEFAULT 0,
    UNIQUE (tenant_id, reference)
);

CREATE INDEX idx_finding_tenant_unit ON finding (tenant_id, org_unit_id);

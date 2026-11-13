-- MIS-02 : types de mission (référentiel tenant, pack), univers auditable, périmètre/budget de mission.
-- Contrat app/planning.yaml (AuditableEntityInput). Dialecte PostgreSQL. Aucune FK vers le plan d'audit
-- (table non encore créée) : audit_plan_item_id est une référence souple, nullable.

CREATE TABLE mission_type (
    tenant_id             UUID NOT NULL,
    code                  VARCHAR(50)  NOT NULL,
    label                 VARCHAR(200) NOT NULL,
    process_key           VARCHAR(100),
    default_duration_days INTEGER,
    active                BOOLEAN NOT NULL DEFAULT TRUE,
    PRIMARY KEY (tenant_id, code)
);

CREATE TABLE auditable_entity (
    id                     UUID PRIMARY KEY,
    tenant_id              UUID NOT NULL,
    code                   VARCHAR(50),
    label                  VARCHAR(300) NOT NULL,
    kind                   VARCHAR(20)  NOT NULL CHECK (kind IN ('ORG_UNIT','PROCESS','SYSTEM','PRODUCT')),
    org_unit_id            UUID REFERENCES org_unit(id),
    owner_user_id          UUID,
    risk_family_codes      TEXT NOT NULL DEFAULT '[]',
    regulatory_requirement TEXT,
    created_at             TIMESTAMPTZ NOT NULL DEFAULT now(),
    version                INTEGER NOT NULL DEFAULT 0,
    UNIQUE (tenant_id, code)
);
CREATE INDEX idx_auditable_entity_tenant_unit ON auditable_entity (tenant_id, org_unit_id);

CREATE TABLE mission_audited_entity (
    mission_id          UUID NOT NULL REFERENCES mission(id) ON DELETE CASCADE,
    auditable_entity_id UUID NOT NULL REFERENCES auditable_entity(id),
    PRIMARY KEY (mission_id, auditable_entity_id)
);
CREATE INDEX idx_mission_audited_entity_ae ON mission_audited_entity (auditable_entity_id);

ALTER TABLE mission ADD COLUMN scope              TEXT;
ALTER TABLE mission ADD COLUMN budget_days        INTEGER;
ALTER TABLE mission ADD COLUMN audit_plan_item_id UUID;

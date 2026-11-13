-- MIS-02 : types de mission, univers auditable, périmètre/budget de mission — dialecte Oracle (D4).
-- risk_family_codes : tableau JSON stocké en CLOB (écart de dialecte, pas de TEXT).

CREATE TABLE mission_type (
    tenant_id             RAW(16) NOT NULL,
    code                  VARCHAR2(50)  NOT NULL,
    label                 VARCHAR2(200) NOT NULL,
    process_key           VARCHAR2(100),
    default_duration_days NUMBER(10),
    active                NUMBER(1) DEFAULT 1 NOT NULL,
    CONSTRAINT pk_mission_type PRIMARY KEY (tenant_id, code)
);

CREATE TABLE auditable_entity (
    id                     RAW(16) PRIMARY KEY,
    tenant_id              RAW(16) NOT NULL,
    code                   VARCHAR2(50),
    label                  VARCHAR2(300) NOT NULL,
    kind                   VARCHAR2(20)  NOT NULL,
    org_unit_id            RAW(16) REFERENCES org_unit(id),
    owner_user_id          RAW(16),
    risk_family_codes      CLOB DEFAULT '[]' NOT NULL,
    regulatory_requirement CLOB,
    created_at             TIMESTAMP WITH TIME ZONE DEFAULT SYSTIMESTAMP NOT NULL,
    version                NUMBER(10) DEFAULT 0 NOT NULL,
    CONSTRAINT ck_auditable_entity_kind CHECK (kind IN ('ORG_UNIT','PROCESS','SYSTEM','PRODUCT')),
    CONSTRAINT uq_auditable_entity_code UNIQUE (tenant_id, code)
);
CREATE INDEX idx_auditable_entity_tenant_unit ON auditable_entity (tenant_id, org_unit_id);

CREATE TABLE mission_audited_entity (
    mission_id          RAW(16) NOT NULL REFERENCES mission(id) ON DELETE CASCADE,
    auditable_entity_id RAW(16) NOT NULL REFERENCES auditable_entity(id),
    CONSTRAINT pk_mission_audited_entity PRIMARY KEY (mission_id, auditable_entity_id)
);
CREATE INDEX idx_mission_audited_entity_ae ON mission_audited_entity (auditable_entity_id);

ALTER TABLE mission ADD (scope CLOB, budget_days NUMBER(10), audit_plan_item_id RAW(16));

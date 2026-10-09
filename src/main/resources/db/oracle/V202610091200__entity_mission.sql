-- Entité Mission (plan §6, contrat app/missions.yaml) — dialecte Oracle (D4).
-- UUID → RAW(16) ; horodatage → TIMESTAMP WITH TIME ZONE ; booléens/entiers → NUMBER.

CREATE TABLE mission (
    id                 RAW(16) PRIMARY KEY,
    tenant_id          RAW(16) NOT NULL,
    org_unit_id        RAW(16) REFERENCES org_unit(id),
    reference          VARCHAR2(50)  NOT NULL,
    title              VARCHAR2(300) NOT NULL,
    mission_type_code  VARCHAR2(50)  NOT NULL,
    mission_type_label VARCHAR2(200) NOT NULL,
    status_code        VARCHAR2(50)  NOT NULL,
    status_label       VARCHAR2(200) NOT NULL,
    phase_code         VARCHAR2(50)  NOT NULL,
    phase_label        VARCHAR2(200) NOT NULL,
    progress_percent   NUMBER(3),
    planned_start      DATE,
    planned_end        DATE,
    created_at         TIMESTAMP WITH TIME ZONE DEFAULT SYSTIMESTAMP NOT NULL,
    version            NUMBER(10) DEFAULT 0 NOT NULL,
    CONSTRAINT uq_mission_reference UNIQUE (tenant_id, reference)
);

CREATE INDEX idx_mission_tenant_unit ON mission (tenant_id, org_unit_id);

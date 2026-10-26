-- Entité Constat / Finding (plan §6, contrat app/findings.yaml) — dialecte Oracle (D4).
-- UUID → RAW(16) ; horodatage → TIMESTAMP WITH TIME ZONE.

CREATE TABLE finding (
    id                 RAW(16) PRIMARY KEY,
    tenant_id          RAW(16) NOT NULL,
    mission_id         RAW(16) REFERENCES mission(id),
    org_unit_id        RAW(16) REFERENCES org_unit(id),
    reference          VARCHAR2(50)  NOT NULL,
    title              VARCHAR2(500) NOT NULL,
    status_code        VARCHAR2(50)  NOT NULL,
    status_label       VARCHAR2(200) NOT NULL,
    criticality_code   VARCHAR2(50),
    criticality_label  VARCHAR2(200),
    source             VARCHAR2(20)  DEFAULT 'MANUAL' NOT NULL,
    created_at         TIMESTAMP WITH TIME ZONE DEFAULT SYSTIMESTAMP NOT NULL,
    version            NUMBER(10) DEFAULT 0 NOT NULL,
    CONSTRAINT uq_finding_reference UNIQUE (tenant_id, reference)
);

CREATE INDEX idx_finding_tenant_unit ON finding (tenant_id, org_unit_id);

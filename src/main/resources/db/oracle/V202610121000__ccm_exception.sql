-- Exception CCM (plan §5.3, D34, contrat app/ccm.yaml) — dialecte Oracle (D4).
-- Mêmes règles qu'en PostgreSQL : le moteur produit des EXCEPTIONS, jamais des constats (D34) ;
-- triage humain puis conversion en constat candidat (§5.3). UUID en RAW(16) ; booléens/statuts inline ;
-- JSON validé par IS JSON (source_record, parameters_used) ; textes longs en CLOB.

CREATE TABLE ccm_exception (
    id                      RAW(16) PRIMARY KEY,
    tenant_id               RAW(16) NOT NULL,
    control_code            VARCHAR2(50)  NOT NULL,
    org_unit_id             RAW(16) REFERENCES org_unit(id),
    reference               VARCHAR2(50)  NOT NULL,
    title                   VARCHAR2(500) NOT NULL,
    criticality_code        VARCHAR2(50),
    criticality_label       VARCHAR2(200),
    status_code             VARCHAR2(50)  DEFAULT 'NEW' NOT NULL,
    status_label            VARCHAR2(200) DEFAULT 'À trier' NOT NULL,
    fact                    CLOB,
    criterion               CLOB,
    source_record           VARCHAR2(4000),
    parameters_used         VARCHAR2(4000),
    data_source             VARCHAR2(200),
    detected_at             TIMESTAMP WITH TIME ZONE DEFAULT SYSTIMESTAMP NOT NULL,
    dismissal_justification CLOB,
    assignee_user_id        RAW(16),
    finding_id              RAW(16) REFERENCES finding(id),
    triaged_by              RAW(16),
    triaged_at              TIMESTAMP WITH TIME ZONE,
    version                 NUMBER(10) DEFAULT 0 NOT NULL,
    CONSTRAINT uq_ccm_exception_reference UNIQUE (tenant_id, reference),
    CONSTRAINT ck_ccm_exc_source_json CHECK (source_record   IS NULL OR source_record   IS JSON),
    CONSTRAINT ck_ccm_exc_params_json CHECK (parameters_used IS NULL OR parameters_used IS JSON)
);

CREATE INDEX idx_ccm_exc_tenant_status ON ccm_exception (tenant_id, status_code);
CREATE INDEX idx_ccm_exc_tenant_unit   ON ccm_exception (tenant_id, org_unit_id);

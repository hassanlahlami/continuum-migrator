-- Preuves rattachées à un constat (ADR 0013, contrat app/findings.yaml attachFindingEvidence) — dialecte Oracle (D4).
-- Métadonnées (finding_evidence) séparées du contenu (evidence_content, BLOB) ; evidence_policy = config tenant.
CREATE TABLE evidence_content (
    tenant_id    RAW(16) NOT NULL,
    storage_key  VARCHAR2(200) NOT NULL,
    sha256       CHAR(64) NOT NULL,
    size_bytes   NUMBER(19) NOT NULL,
    content      BLOB NOT NULL,
    created_at   TIMESTAMP WITH TIME ZONE DEFAULT SYSTIMESTAMP NOT NULL,
    CONSTRAINT pk_evidence_content PRIMARY KEY (tenant_id, storage_key)
);

CREATE TABLE finding_evidence (
    id            RAW(16) PRIMARY KEY,
    tenant_id     RAW(16) NOT NULL,
    finding_id    RAW(16) NOT NULL REFERENCES finding(id),
    file_name     VARCHAR2(500) NOT NULL,
    content_type  VARCHAR2(200) NOT NULL,
    size_bytes    NUMBER(19) NOT NULL,
    storage_key   VARCHAR2(200) NOT NULL,
    uploaded_by   RAW(16) NOT NULL,
    uploaded_at   TIMESTAMP WITH TIME ZONE DEFAULT SYSTIMESTAMP NOT NULL,
    CONSTRAINT fk_finding_evidence_content FOREIGN KEY (tenant_id, storage_key) REFERENCES evidence_content (tenant_id, storage_key)
);

CREATE INDEX idx_finding_evidence_finding ON finding_evidence (tenant_id, finding_id);

CREATE TABLE evidence_policy (
    tenant_id          RAW(16) PRIMARY KEY,
    max_size_bytes     NUMBER(19) NOT NULL,
    allowed_mime_types VARCHAR2(2000) NOT NULL,
    version            NUMBER(10) DEFAULT 0 NOT NULL
);

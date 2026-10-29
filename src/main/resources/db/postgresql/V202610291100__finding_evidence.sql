-- Preuves rattachées à un constat (ADR 0013, contrat app/findings.yaml attachFindingEvidence) — dialecte PostgreSQL.
-- finding_evidence = métadonnées seules (jamais de contenu : listes légères) ; evidence_content = octets (BYTEA),
-- joint par (tenant_id, storage_key). evidence_policy = taille max et types MIME par tenant (aucune valeur en dur, §1.6).
CREATE TABLE evidence_content (
    tenant_id    UUID NOT NULL,
    storage_key  VARCHAR(200) NOT NULL,
    sha256       CHAR(64) NOT NULL,
    size_bytes   BIGINT NOT NULL,
    content      BYTEA NOT NULL,
    created_at   TIMESTAMPTZ NOT NULL DEFAULT now(),
    PRIMARY KEY (tenant_id, storage_key)
);

CREATE TABLE finding_evidence (
    id            UUID PRIMARY KEY,
    tenant_id     UUID NOT NULL,
    finding_id    UUID NOT NULL REFERENCES finding(id),
    file_name     VARCHAR(500) NOT NULL,
    content_type  VARCHAR(200) NOT NULL,
    size_bytes    BIGINT NOT NULL,
    storage_key   VARCHAR(200) NOT NULL,
    uploaded_by   UUID NOT NULL,
    uploaded_at   TIMESTAMPTZ NOT NULL DEFAULT now(),
    FOREIGN KEY (tenant_id, storage_key) REFERENCES evidence_content (tenant_id, storage_key)
);

CREATE INDEX idx_finding_evidence_finding ON finding_evidence (tenant_id, finding_id);

-- Politique de dépôt par tenant ; défauts livrés par le pack (valeurs ⟨à valider⟩, QUESTIONS.md).
CREATE TABLE evidence_policy (
    tenant_id          UUID PRIMARY KEY,
    max_size_bytes     BIGINT NOT NULL,
    allowed_mime_types VARCHAR(2000) NOT NULL,
    version            INTEGER NOT NULL DEFAULT 0
);

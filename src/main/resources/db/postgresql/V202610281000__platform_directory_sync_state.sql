-- État de synchronisation des annuaires — une ligne par source d'annuaire et par tenant (brouillon, colonnes ⟨à valider⟩ avec backend) — dialecte PostgreSQL.
-- last_sync_at = fin de la dernière synchronisation réussie (alimente lastDirectorySyncAt de GET /overview) ; NULL tant qu'aucune n'a abouti.
-- status = état de la dernière tentative ; version = verrou optimiste.
CREATE TABLE platform.directory_sync_state (
    id              UUID PRIMARY KEY,
    tenant_id       UUID NOT NULL REFERENCES platform.tenant (id),
    source_code     VARCHAR(100) NOT NULL,
    last_sync_at    TIMESTAMP WITH TIME ZONE,
    status          VARCHAR(20)  NOT NULL DEFAULT 'NEVER',
    last_error      VARCHAR(1000),
    version         BIGINT NOT NULL DEFAULT 0,
    CONSTRAINT uq_directory_sync_state_source UNIQUE (tenant_id, source_code),
    CONSTRAINT ck_directory_sync_state_status CHECK (status IN ('NEVER', 'RUNNING', 'SUCCESS', 'FAILED'))
);

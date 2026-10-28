-- État de synchronisation des annuaires (brouillon) — dialecte Oracle : UUID → RAW(16) ; VARCHAR → VARCHAR2.
CREATE TABLE platform.directory_sync_state (
    id              RAW(16) PRIMARY KEY,
    tenant_id       RAW(16) NOT NULL REFERENCES platform.tenant (id),
    source_code     VARCHAR2(100) NOT NULL,
    last_sync_at    TIMESTAMP WITH TIME ZONE,
    status          VARCHAR2(20)  DEFAULT 'NEVER' NOT NULL,
    last_error      VARCHAR2(1000),
    version         NUMBER(19) DEFAULT 0 NOT NULL,
    CONSTRAINT uq_directory_sync_state_source UNIQUE (tenant_id, source_code),
    CONSTRAINT ck_directory_sync_state_status CHECK (status IN ('NEVER', 'RUNNING', 'SUCCESS', 'FAILED'))
);

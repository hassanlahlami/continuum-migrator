-- Comptes utilisateurs de l'installation (D40) — dialecte Oracle : UUID → RAW(16) ; BOOLEAN → NUMBER(1).
CREATE TABLE platform.user_account (
    id              RAW(16) PRIMARY KEY,
    tenant_id       RAW(16) NOT NULL REFERENCES platform.tenant (id),
    username        VARCHAR2(100) NOT NULL,
    source          VARCHAR2(10)  NOT NULL,
    status          VARCHAR2(20)  DEFAULT 'ACTIVE' NOT NULL,
    mfa_configured  NUMBER(1) DEFAULT 0 NOT NULL CHECK (mfa_configured IN (0, 1)),
    last_login      TIMESTAMP WITH TIME ZONE,
    version         NUMBER(19) DEFAULT 0 NOT NULL,
    CONSTRAINT uq_user_account_username UNIQUE (tenant_id, username),
    CONSTRAINT ck_user_account_source CHECK (source IN ('AD', 'LOCAL')),
    CONSTRAINT ck_user_account_status CHECK (status IN ('ACTIVE', 'LOCKED', 'DISABLED', 'NO_ASSIGNMENT'))
);

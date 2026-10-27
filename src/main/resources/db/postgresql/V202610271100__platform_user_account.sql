-- Comptes utilisateurs de l'installation (D40) — état de compte porté par la plateforme, lu par le contrôle de connexion (SPI) — dialecte PostgreSQL.
-- status = statut de compte du contrat (UserAccount.accountStatus) ; version = verrou optimiste (409 si périmée).
CREATE TABLE platform.user_account (
    id              UUID PRIMARY KEY,
    tenant_id       UUID NOT NULL REFERENCES platform.tenant (id),
    username        VARCHAR(100) NOT NULL,
    source          VARCHAR(10)  NOT NULL,
    status          VARCHAR(20)  NOT NULL DEFAULT 'ACTIVE',
    mfa_configured  BOOLEAN NOT NULL DEFAULT FALSE,
    last_login      TIMESTAMP WITH TIME ZONE,
    version         BIGINT NOT NULL DEFAULT 0,
    CONSTRAINT uq_user_account_username UNIQUE (tenant_id, username),
    CONSTRAINT ck_user_account_source CHECK (source IN ('AD', 'LOCAL')),
    CONSTRAINT ck_user_account_status CHECK (status IN ('ACTIVE', 'LOCKED', 'DISABLED', 'NO_ASSIGNMENT'))
);

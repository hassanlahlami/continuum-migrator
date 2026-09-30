-- Schéma partagé "platform" — catalogue de fonctionnalités et activation par module (plan §2.1.6).
-- Dialecte Oracle (D3/D4) : pas de type BOOLEAN portable → NUMBER(1) ; UUID → RAW(16).
-- Le schéma "platform" est un utilisateur/schéma Oracle créé en amont par le DBA (§4.3.5).

CREATE TABLE platform.feature (
    code       VARCHAR2(100) PRIMARY KEY,
    module     VARCHAR2(50)  NOT NULL,
    label_key  VARCHAR2(150) NOT NULL,
    scopable   NUMBER(1) DEFAULT 1 NOT NULL CHECK (scopable  IN (0, 1)),
    sensitive  NUMBER(1) DEFAULT 0 NOT NULL CHECK (sensitive IN (0, 1)),
    deprecated NUMBER(1) DEFAULT 0 NOT NULL CHECK (deprecated IN (0, 1))
);

CREATE INDEX idx_feature_module ON platform.feature (module);

CREATE TABLE platform.tenant_module (
    tenant_id RAW(16)      NOT NULL,
    module    VARCHAR2(50) NOT NULL,
    enabled   NUMBER(1)    NOT NULL CHECK (enabled IN (0, 1)),
    PRIMARY KEY (tenant_id, module)
);

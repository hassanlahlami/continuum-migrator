-- Registre des entités (tenants) de l'installation (plan §4.7) — schéma partagé "platform".
-- Dialecte Oracle : UUID → RAW(16) ; BOOLEAN → NUMBER(1). Le schéma PLATFORM est créé en amont.

CREATE TABLE platform.tenant (
    id         RAW(16) PRIMARY KEY,
    code       VARCHAR2(50)  NOT NULL,
    label      VARCHAR2(200) NOT NULL,
    active     NUMBER(1) DEFAULT 1 NOT NULL CHECK (active IN (0, 1)),
    created_at TIMESTAMP WITH TIME ZONE DEFAULT SYSTIMESTAMP NOT NULL,
    CONSTRAINT uq_tenant_code UNIQUE (code)
);

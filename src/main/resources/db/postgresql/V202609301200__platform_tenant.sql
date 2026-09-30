-- Registre des entités (tenants) de l'installation (plan §4.7) — schéma partagé "platform".
-- Dialecte PostgreSQL.

CREATE SCHEMA IF NOT EXISTS platform;

CREATE TABLE platform.tenant (
    id         UUID PRIMARY KEY,
    code       VARCHAR(50)  NOT NULL UNIQUE,      -- ex. BANQUE-DEMO
    label      VARCHAR(200) NOT NULL,
    active     BOOLEAN NOT NULL DEFAULT TRUE,
    created_at TIMESTAMPTZ NOT NULL DEFAULT now()
);

-- Schéma partagé "platform" — catalogue de fonctionnalités et activation par module (plan §2.1.6).
-- Dialecte PostgreSQL (D3/D4). Migration versionnée, forward-only (D33, §4.3.5).

CREATE SCHEMA IF NOT EXISTS platform;

-- Catalogue plateforme : synchronisé au démarrage depuis le registre Java Feature (§2.1.7).
CREATE TABLE platform.feature (
    code       VARCHAR(100) PRIMARY KEY,            -- 'mission.order.approve'
    module     VARCHAR(50)  NOT NULL,               -- domaine fonctionnel (FeatureModule)
    label_key  VARCHAR(150) NOT NULL,               -- clé i18n
    scopable   BOOLEAN NOT NULL DEFAULT TRUE,       -- s'évalue sur une unité/mission
    sensitive  BOOLEAN NOT NULL DEFAULT FALSE,      -- step-up MFA + maker-checker sur l'octroi
    deprecated BOOLEAN NOT NULL DEFAULT FALSE        -- retirée mais conservée pour l'historique
);

CREATE INDEX idx_feature_module ON platform.feature (module);

-- Activation des modules par tenant (§2.1.4, point 3).
CREATE TABLE platform.tenant_module (
    tenant_id UUID        NOT NULL,
    module    VARCHAR(50) NOT NULL,
    enabled   BOOLEAN     NOT NULL,
    PRIMARY KEY (tenant_id, module)
);

-- Schéma "entity" (une filiale/tenant) — structure IAM (plan §2.1.6).
-- Dialecte PostgreSQL : arbre d'unités par ltree + index GiST (D4) ; libellés i18n en JSONB.
-- role_feature référence le catalogue partagé platform.feature (§4.3.5, cross-schema).

CREATE EXTENSION IF NOT EXISTS ltree;

-- Rôles du tenant (organisationnels ou de mission) (§2.1.1).
CREATE TABLE role (
    id        UUID PRIMARY KEY,
    tenant_id UUID NOT NULL,
    code      VARCHAR(50) NOT NULL,
    label     JSONB NOT NULL,                                  -- {"fr":"…","ar":"…","en":"…"}
    kind      VARCHAR(20) NOT NULL CHECK (kind IN ('ORGANISATIONAL', 'MISSION')),
    from_pack BOOLEAN NOT NULL DEFAULT FALSE,
    UNIQUE (tenant_id, code)
);

-- Rôle ↔ fonctionnalités (le code référence le catalogue plateforme).
CREATE TABLE role_feature (
    role_id      UUID NOT NULL REFERENCES role(id) ON DELETE CASCADE,
    feature_code VARCHAR(100) NOT NULL REFERENCES platform.feature(code),
    PRIMARY KEY (role_id, feature_code)
);

-- Types d'unités organisationnelles (Direction, Division, Service…).
CREATE TABLE org_unit_type (
    id        UUID PRIMARY KEY,
    tenant_id UUID NOT NULL,
    code      VARCHAR(50) NOT NULL,
    label     JSONB NOT NULL,
    depth     SMALLINT NOT NULL,
    UNIQUE (tenant_id, code)
);

-- Arbre des unités (chemin matérialisé ltree).
CREATE TABLE org_unit (
    id        UUID PRIMARY KEY,
    tenant_id UUID NOT NULL,
    type_id   UUID NOT NULL REFERENCES org_unit_type(id),
    parent_id UUID REFERENCES org_unit(id),
    code      VARCHAR(50) NOT NULL,
    label     JSONB NOT NULL,
    path      LTREE NOT NULL,                                  -- 'root.dir_audit.div_fin'
    UNIQUE (tenant_id, code)
);
CREATE INDEX idx_org_unit_path ON org_unit USING GIST (path);

-- Positions (abstraction du poste client) (§2.1.2).
CREATE TABLE position (
    id                   UUID PRIMARY KEY,
    tenant_id            UUID NOT NULL,
    code                 VARCHAR(50) NOT NULL,
    label                JSONB NOT NULL,
    rank                 SMALLINT NOT NULL,                    -- 10 = sommet
    unit_type_id         UUID REFERENCES org_unit_type(id),   -- NULL = niveau tenant
    scope                VARCHAR(20) NOT NULL CHECK (scope IN ('UNIT', 'UNIT_TREE', 'TENANT')),
    reports_to_id        UUID REFERENCES position(id),
    max_holders_per_unit SMALLINT,
    active               BOOLEAN NOT NULL DEFAULT TRUE,
    UNIQUE (tenant_id, code)
);

CREATE TABLE position_role (
    position_id UUID NOT NULL REFERENCES position(id) ON DELETE CASCADE,
    role_id     UUID NOT NULL REFERENCES role(id),
    PRIMARY KEY (position_id, role_id)
);

-- Affectations datées : titulaire, intérim, délégation (§2.1.3).
CREATE TABLE assignment (
    id           UUID PRIMARY KEY,
    tenant_id    UUID NOT NULL,
    user_id      UUID NOT NULL,
    position_id  UUID NOT NULL REFERENCES position(id),
    org_unit_id  UUID REFERENCES org_unit(id),                -- NULL si position de niveau tenant
    kind         VARCHAR(20) NOT NULL CHECK (kind IN ('HOLDER', 'INTERIM', 'DELEGATION')),
    delegated_by UUID,                                        -- délégant (DELEGATION)
    valid_from   DATE NOT NULL,
    valid_to     DATE,
    approved_by  UUID,                                        -- maker-checker
    CHECK (valid_to IS NULL OR valid_to >= valid_from)
);

-- Délégation partielle : sous-ensemble de fonctionnalités.
CREATE TABLE assignment_feature_restriction (
    assignment_id UUID NOT NULL REFERENCES assignment(id) ON DELETE CASCADE,
    feature_code  VARCHAR(100) NOT NULL REFERENCES platform.feature(code),
    PRIMARY KEY (assignment_id, feature_code)
);

-- Rôles contextuels de mission (§2.1.1).
CREATE TABLE mission_member (
    mission_id UUID NOT NULL,
    user_id    UUID NOT NULL,
    role_id    UUID NOT NULL REFERENCES role(id),             -- role.kind = 'MISSION'
    valid_from DATE NOT NULL,
    valid_to   DATE,
    PRIMARY KEY (mission_id, user_id, role_id)
);

-- Séparation des tâches (§2.2).
CREATE TABLE sod_rule (
    id        UUID PRIMARY KEY,
    tenant_id UUID NOT NULL,
    feature_a VARCHAR(100) NOT NULL REFERENCES platform.feature(code),
    feature_b VARCHAR(100) NOT NULL REFERENCES platform.feature(code),
    type      VARCHAR(10) NOT NULL CHECK (type IN ('STATIC', 'DYNAMIC')),
    severity  VARCHAR(10) NOT NULL CHECK (severity IN ('BLOCK', 'WARN'))
);

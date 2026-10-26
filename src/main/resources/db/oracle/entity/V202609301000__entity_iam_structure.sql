-- Schéma "entity" (une filiale/tenant) — structure IAM (plan §2.1.6).
-- Dialecte Oracle (D4) : pas de ltree → adjacence (parent_id, CONNECT BY) + TABLE DE FERMETURE ;
-- UUID → RAW(16) ; BOOLEAN → NUMBER(1) ; libellés i18n en VARCHAR2 contraint IS JSON.
-- role_feature référence le catalogue partagé PLATFORM.FEATURE (§4.3.5, cross-schema).

CREATE TABLE role (
    id        RAW(16) PRIMARY KEY,
    tenant_id RAW(16) NOT NULL,
    code      VARCHAR2(50) NOT NULL,
    label     VARCHAR2(2000) NOT NULL CHECK (label IS JSON),
    kind      VARCHAR2(20) NOT NULL CHECK (kind IN ('ORGANISATIONAL', 'MISSION')),
    from_pack NUMBER(1) DEFAULT 0 NOT NULL CHECK (from_pack IN (0, 1)),
    CONSTRAINT uq_role_code UNIQUE (tenant_id, code)
);

CREATE TABLE role_feature (
    role_id      RAW(16) NOT NULL,
    feature_code VARCHAR2(100) NOT NULL,
    CONSTRAINT pk_role_feature PRIMARY KEY (role_id, feature_code),
    CONSTRAINT fk_rf_role    FOREIGN KEY (role_id) REFERENCES role(id) ON DELETE CASCADE,
    CONSTRAINT fk_rf_feature FOREIGN KEY (feature_code) REFERENCES platform.feature(code)
);

CREATE TABLE org_unit_type (
    id        RAW(16) PRIMARY KEY,
    tenant_id RAW(16) NOT NULL,
    code      VARCHAR2(50) NOT NULL,
    label     VARCHAR2(2000) NOT NULL CHECK (label IS JSON),
    depth     NUMBER(5) NOT NULL,
    CONSTRAINT uq_org_unit_type_code UNIQUE (tenant_id, code)
);

-- Arbre des unités par adjacence (CONNECT BY sur parent_id).
CREATE TABLE org_unit (
    id        RAW(16) PRIMARY KEY,
    tenant_id RAW(16) NOT NULL,
    type_id   RAW(16) NOT NULL REFERENCES org_unit_type(id),
    parent_id RAW(16) REFERENCES org_unit(id),
    code      VARCHAR2(50) NOT NULL,
    label     VARCHAR2(2000) NOT NULL CHECK (label IS JSON),
    CONSTRAINT uq_org_unit_code UNIQUE (tenant_id, code)
);
CREATE INDEX idx_org_unit_parent ON org_unit (parent_id);

-- Table de fermeture : ancêtre → descendant (portée UNIT_TREE sans CONNECT BY récurrent).
CREATE TABLE org_unit_closure (
    ancestor_id   RAW(16) NOT NULL REFERENCES org_unit(id),
    descendant_id RAW(16) NOT NULL REFERENCES org_unit(id),
    depth         NUMBER(5) NOT NULL,
    CONSTRAINT pk_org_unit_closure PRIMARY KEY (ancestor_id, descendant_id)
);
CREATE INDEX idx_ouc_descendant ON org_unit_closure (descendant_id);

CREATE TABLE position (
    id                   RAW(16) PRIMARY KEY,
    tenant_id            RAW(16) NOT NULL,
    code                 VARCHAR2(50) NOT NULL,
    label                VARCHAR2(2000) NOT NULL CHECK (label IS JSON),
    rank                 NUMBER(5) NOT NULL,
    unit_type_id         RAW(16) REFERENCES org_unit_type(id),
    scope                VARCHAR2(20) NOT NULL CHECK (scope IN ('UNIT', 'UNIT_TREE', 'TENANT')),
    reports_to_id        RAW(16) REFERENCES position(id),
    max_holders_per_unit NUMBER(5),
    active               NUMBER(1) DEFAULT 1 NOT NULL CHECK (active IN (0, 1)),
    CONSTRAINT uq_position_code UNIQUE (tenant_id, code)
);

CREATE TABLE position_role (
    position_id RAW(16) NOT NULL,
    role_id     RAW(16) NOT NULL,
    CONSTRAINT pk_position_role PRIMARY KEY (position_id, role_id),
    CONSTRAINT fk_pr_position FOREIGN KEY (position_id) REFERENCES position(id) ON DELETE CASCADE,
    CONSTRAINT fk_pr_role     FOREIGN KEY (role_id) REFERENCES role(id)
);

CREATE TABLE assignment (
    id           RAW(16) PRIMARY KEY,
    tenant_id    RAW(16) NOT NULL,
    user_id      RAW(16) NOT NULL,
    position_id  RAW(16) NOT NULL REFERENCES position(id),
    org_unit_id  RAW(16) REFERENCES org_unit(id),
    kind         VARCHAR2(20) NOT NULL CHECK (kind IN ('HOLDER', 'INTERIM', 'DELEGATION')),
    delegated_by RAW(16),
    valid_from   DATE NOT NULL,
    valid_to     DATE,
    approved_by  RAW(16),
    CONSTRAINT ck_assignment_dates CHECK (valid_to IS NULL OR valid_to >= valid_from)
);

CREATE TABLE assignment_feature_restriction (
    assignment_id RAW(16) NOT NULL,
    feature_code  VARCHAR2(100) NOT NULL,
    CONSTRAINT pk_afr PRIMARY KEY (assignment_id, feature_code),
    CONSTRAINT fk_afr_assignment FOREIGN KEY (assignment_id) REFERENCES assignment(id) ON DELETE CASCADE,
    CONSTRAINT fk_afr_feature    FOREIGN KEY (feature_code) REFERENCES platform.feature(code)
);

CREATE TABLE mission_member (
    mission_id RAW(16) NOT NULL,
    user_id    RAW(16) NOT NULL,
    role_id    RAW(16) NOT NULL REFERENCES role(id),
    valid_from DATE NOT NULL,
    valid_to   DATE,
    CONSTRAINT pk_mission_member PRIMARY KEY (mission_id, user_id, role_id)
);

CREATE TABLE sod_rule (
    id        RAW(16) PRIMARY KEY,
    tenant_id RAW(16) NOT NULL,
    feature_a VARCHAR2(100) NOT NULL REFERENCES platform.feature(code),
    feature_b VARCHAR2(100) NOT NULL REFERENCES platform.feature(code),
    type      VARCHAR2(10) NOT NULL CHECK (type IN ('STATIC', 'DYNAMIC')),
    severity  VARCHAR2(10) NOT NULL CHECK (severity IN ('BLOCK', 'WARN'))
);

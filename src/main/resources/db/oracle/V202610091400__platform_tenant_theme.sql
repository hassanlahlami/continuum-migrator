-- Thème du tenant (plan §1.6) — dialecte Oracle (D4). Tokens --ct-* en JSON (VARCHAR2 IS JSON).

CREATE TABLE tenant_theme (
    tenant_id  RAW(16) PRIMARY KEY,
    tokens     VARCHAR2(4000) NOT NULL CONSTRAINT ck_tenant_theme_json CHECK (tokens IS JSON),
    version    NUMBER(10) DEFAULT 1 NOT NULL,
    updated_at TIMESTAMP WITH TIME ZONE DEFAULT SYSTIMESTAMP NOT NULL
);

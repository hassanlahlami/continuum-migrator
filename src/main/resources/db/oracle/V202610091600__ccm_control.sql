-- Paramétrage des contrôles CCM (plan §5, CCM-03) — dialecte Oracle (D4).
-- Mêmes règles qu'en PostgreSQL : seuils/fréquences = données du tenant, jamais codées en dur.
-- UUID en RAW(16) ; booléen NUMBER(1) ; params JSON validé (IS JSON) en VARCHAR2.

CREATE TABLE ccm_control (
    tenant_id    RAW(16)       NOT NULL,
    control_code VARCHAR2(50)  NOT NULL,
    enabled      NUMBER(1)     DEFAULT 1 NOT NULL,
    params       VARCHAR2(4000) DEFAULT '{}' NOT NULL,
    updated_at   TIMESTAMP     DEFAULT SYSTIMESTAMP NOT NULL,
    CONSTRAINT pk_ccm_control PRIMARY KEY (tenant_id, control_code),
    CONSTRAINT ck_ccm_control_params_json CHECK (params IS JSON)
);

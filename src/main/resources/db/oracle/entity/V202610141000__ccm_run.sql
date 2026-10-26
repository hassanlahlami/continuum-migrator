-- Exécution d'un contrôle CCM (plan §5, contrat app/ccm.yaml CcmRun) — dialecte Oracle (D4).
-- Mêmes règles qu'en PostgreSQL : historique des passages d'un contrôle, base de la santé réelle et des
-- métriques du cockpit (§5). UUID en RAW(16) ; entiers en NUMBER ; paramètres JSON validés par IS JSON ;
-- message d'échec en CLOB. « trigger » étant réservé, la colonne est trigger_type.

CREATE TABLE ccm_run (
    id               RAW(16) PRIMARY KEY,
    tenant_id        RAW(16) NOT NULL,
    control_code     VARCHAR2(50)  NOT NULL,
    status           VARCHAR2(50)  NOT NULL,
    trigger_type     VARCHAR2(50)  DEFAULT 'SCHEDULE' NOT NULL,
    started_at       TIMESTAMP WITH TIME ZONE DEFAULT SYSTIMESTAMP NOT NULL,
    finished_at      TIMESTAMP WITH TIME ZONE,
    population_size  NUMBER(19),
    exceptions_count NUMBER(10),
    data_source      VARCHAR2(200),
    parameters_used  VARCHAR2(4000),
    problem_detail   CLOB,
    version          NUMBER(10) DEFAULT 0 NOT NULL,
    CONSTRAINT ck_ccm_run_params_json CHECK (parameters_used IS NULL OR parameters_used IS JSON)
);

CREATE INDEX idx_ccm_run_tenant_ctrl_started ON ccm_run (tenant_id, control_code, started_at DESC);
CREATE INDEX idx_ccm_run_tenant_started      ON ccm_run (tenant_id, started_at DESC);

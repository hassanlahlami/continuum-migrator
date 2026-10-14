-- Exécution d'un contrôle CCM (plan §5, contrat app/ccm.yaml CcmRun) — dialecte PostgreSQL.
-- Historise chaque passage d'un contrôle (continu, planifié, événementiel ou manuel) : statut, fenêtre,
-- taille de population, nombre d'exceptions produites, paramètres utilisés (rejouabilité) et source de
-- données. C'est l'historique des runs qui donne l'état de SANTÉ réel d'un contrôle (OK/DRIFT/FAILING)
-- et les métriques du cockpit (§5) — tant qu'aucun run n'existe, la santé reste NEVER_RUN.

CREATE TABLE ccm_run (
    id               UUID PRIMARY KEY,
    tenant_id        UUID NOT NULL,
    control_code     VARCHAR(50)  NOT NULL,            -- ex. SOD-VIREMENTS, SEUIL-HORAIRE, COMPTES-DORMANTS
    status           VARCHAR(50)  NOT NULL,            -- RUNNING / SUCCEEDED / FAILED
    trigger_type     VARCHAR(50)  NOT NULL DEFAULT 'SCHEDULE', -- SCHEDULE / EVENT / MANUAL
    started_at       TIMESTAMPTZ  NOT NULL DEFAULT now(),
    finished_at      TIMESTAMPTZ,
    population_size  BIGINT,                           -- population testée (NULL si non applicable, ex. SoD)
    exceptions_count INTEGER,                          -- exceptions produites par ce run
    data_source      VARCHAR(200),                     -- origine des données testées
    parameters_used  JSONB,                            -- paramètres d'exécution (rejouabilité, §5)
    problem_detail   TEXT,                             -- message d'échec si status = FAILED
    version          INTEGER NOT NULL DEFAULT 0
);

CREATE INDEX idx_ccm_run_tenant_control_started ON ccm_run (tenant_id, control_code, started_at DESC);
CREATE INDEX idx_ccm_run_tenant_started         ON ccm_run (tenant_id, started_at DESC);

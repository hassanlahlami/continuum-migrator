-- Exception CCM : rattachement au run qui l'a produite (contrat CcmException.runId) et à la mission
-- retenue lors du triage (§5.3). Dialecte Oracle (D4), mêmes règles qu'en PostgreSQL.
ALTER TABLE ccm_exception ADD (run_id RAW(16) REFERENCES ccm_run(id));
ALTER TABLE ccm_exception ADD (mission_id RAW(16) REFERENCES mission(id));

CREATE INDEX idx_ccm_exc_run ON ccm_exception (run_id);

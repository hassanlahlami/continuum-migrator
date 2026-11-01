-- Exception CCM : rattachement au run qui l'a produite (contrat CcmException.runId) et à la mission
-- retenue lors du triage (§5.3 : exception retenue → constat candidat rattaché à une mission). Dialecte PostgreSQL.
ALTER TABLE ccm_exception ADD COLUMN run_id UUID REFERENCES ccm_run(id);
ALTER TABLE ccm_exception ADD COLUMN mission_id UUID REFERENCES mission(id);

CREATE INDEX idx_ccm_exception_run ON ccm_exception (run_id);

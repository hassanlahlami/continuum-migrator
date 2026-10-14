-- Exception CCM (plan §5.3, D34, contrat app/ccm.yaml) — dialecte PostgreSQL.
-- Audit PAR EXCEPTION : le moteur CCM ne crée JAMAIS de constat directement (D34). Il produit des
-- EXCEPTIONS ; un auditeur habilité les trie (retenir / écarter avec justification / affecter), et une
-- exception RETENUE devient un constat candidat rattaché à une mission (§5.3). L'exception porte la
-- chaîne de preuve : paramètres d'exécution, source de données, enregistrement source du CBS.
-- Statut/criticité : libellés inline en attendant le module de paramétrage (§1.6), comme pour `finding`.

CREATE TABLE ccm_exception (
    id                      UUID PRIMARY KEY,
    tenant_id               UUID NOT NULL,
    control_code            VARCHAR(50)  NOT NULL,            -- code du contrôle du catalogue : SOD-VIREMENTS, SEUIL-HORAIRE, COMPTES-DORMANTS
    org_unit_id             UUID REFERENCES org_unit(id),
    reference               VARCHAR(50)  NOT NULL,            -- clé stable de dé-doublonnage (idempotence)
    title                   VARCHAR(500) NOT NULL,
    criticality_code        VARCHAR(50),
    criticality_label       VARCHAR(200),
    status_code             VARCHAR(50)  NOT NULL DEFAULT 'NEW',
    status_label            VARCHAR(200) NOT NULL DEFAULT 'À trier',
    fact                    TEXT,                             -- pré-remplissage FRAP à la conversion
    criterion               TEXT,
    source_record           JSONB,                            -- enregistrement source du CBS (modèle canonique)
    parameters_used         JSONB,                            -- paramètres d'exécution (rejouabilité, §5.3)
    data_source             VARCHAR(200),                     -- origine des données testées
    detected_at             TIMESTAMPTZ NOT NULL DEFAULT now(),
    dismissal_justification TEXT,                             -- obligatoire si écartée (§5.3)
    assignee_user_id        UUID,
    finding_id              UUID REFERENCES finding(id),      -- renseigné après conversion en constat
    triaged_by              UUID,
    triaged_at              TIMESTAMPTZ,
    version                 INTEGER NOT NULL DEFAULT 0,
    UNIQUE (tenant_id, reference)
);

CREATE INDEX idx_ccm_exception_tenant_status ON ccm_exception (tenant_id, status_code);
CREATE INDEX idx_ccm_exception_tenant_unit   ON ccm_exception (tenant_id, org_unit_id);

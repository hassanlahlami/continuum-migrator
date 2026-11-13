-- Jeu de données de démonstration (D37, §8.7) — socle IAM minimal pour le flux de connexion E2E.
-- Tenant « Banque Démo », une unité (Inspection Générale), un rôle inspecteur (lecture missions +
-- lecture/rédaction constats), une position de portée UNIT_TREE, et l'affectation de l'utilisateur
-- de démonstration `ig.demo` (continuum_user_id = 2222…). Rejouable (ON CONFLICT DO NOTHING).
-- Les claims du jeton Keycloak (tenant_id, continuum_user_id) doivent correspondre à ces UUID.

INSERT INTO platform.tenant (id, code, label, active) VALUES
 ('11111111-1111-1111-1111-111111111111', 'BANQUE-DEMO', 'Banque Démo', true)
 ON CONFLICT (id) DO NOTHING;

INSERT INTO platform.tenant_module (tenant_id, module, enabled) VALUES
 ('11111111-1111-1111-1111-111111111111', 'MISSION', true),
 ('11111111-1111-1111-1111-111111111111', 'FINDING', true),
 ('11111111-1111-1111-1111-111111111111', 'ADMIN', true),
 ('11111111-1111-1111-1111-111111111111', 'OPS', true),
 ('11111111-1111-1111-1111-111111111111', 'CCM', true)
 ON CONFLICT DO NOTHING;

INSERT INTO org_unit_type (id, tenant_id, code, label, depth) VALUES
 ('a1111111-1111-1111-1111-111111111111', '11111111-1111-1111-1111-111111111111', 'DIR', '{"fr":"Direction"}', 1)
 ON CONFLICT DO NOTHING;

INSERT INTO org_unit (id, tenant_id, type_id, parent_id, code, label, path) VALUES
 ('b1111111-1111-1111-1111-111111111111', '11111111-1111-1111-1111-111111111111',
  'a1111111-1111-1111-1111-111111111111', NULL, 'IG', '{"fr":"Inspection Générale"}', 'ig')
 ON CONFLICT DO NOTHING;

INSERT INTO role (id, tenant_id, code, label, kind) VALUES
 ('c1111111-1111-1111-1111-111111111111', '11111111-1111-1111-1111-111111111111',
  'INSPECTEUR', '{"fr":"Inspecteur"}', 'ORGANISATIONAL')
 ON CONFLICT DO NOTHING;

INSERT INTO role_feature (role_id, feature_code) VALUES
 ('c1111111-1111-1111-1111-111111111111', 'mission.read'),
 ('c1111111-1111-1111-1111-111111111111', 'finding.read'),
 ('c1111111-1111-1111-1111-111111111111', 'finding.write'),
 ('c1111111-1111-1111-1111-111111111111', 'ccm.read')
 ON CONFLICT DO NOTHING;

INSERT INTO position (id, tenant_id, code, label, rank, scope) VALUES
 ('d1111111-1111-1111-1111-111111111111', '11111111-1111-1111-1111-111111111111',
  'INSPECTEUR', '{"fr":"Inspecteur"}', 30, 'UNIT_TREE')
 ON CONFLICT DO NOTHING;

INSERT INTO position_role (position_id, role_id) VALUES
 ('d1111111-1111-1111-1111-111111111111', 'c1111111-1111-1111-1111-111111111111')
 ON CONFLICT DO NOTHING;

INSERT INTO assignment (id, tenant_id, user_id, position_id, org_unit_id, kind, valid_from) VALUES
 ('e1111111-1111-1111-1111-111111111111', '11111111-1111-1111-1111-111111111111',
  '22222222-2222-2222-2222-222222222222', 'd1111111-1111-1111-1111-111111111111',
  'b1111111-1111-1111-1111-111111111111', 'HOLDER', CURRENT_DATE)
 ON CONFLICT DO NOTHING;

-- Position VALIDATEUR (porte finding.validate), NON affectée : c'est l'octroi que l'Admin Système
-- réalise depuis l'écran « Affecter une position ». Après l'affectation à ig.demo, le client gagne
-- le droit finding.validate (démonstration du flux admin→client).
INSERT INTO role (id, tenant_id, code, label, kind) VALUES
 ('c2222222-2222-2222-2222-222222222222', '11111111-1111-1111-1111-111111111111',
  'VALIDATEUR', '{"fr":"Valideur de constats"}', 'ORGANISATIONAL')
 ON CONFLICT DO NOTHING;
INSERT INTO role_feature (role_id, feature_code) VALUES
 ('c2222222-2222-2222-2222-222222222222', 'finding.validate')
 ON CONFLICT DO NOTHING;
INSERT INTO position (id, tenant_id, code, label, rank, scope) VALUES
 ('d2222222-2222-2222-2222-222222222222', '11111111-1111-1111-1111-111111111111',
  'VALIDATEUR', '{"fr":"Valideur de constats"}', 40, 'UNIT_TREE')
 ON CONFLICT DO NOTHING;
INSERT INTO position_role (position_id, role_id) VALUES
 ('d2222222-2222-2222-2222-222222222222', 'c2222222-2222-2222-2222-222222222222')
 ON CONFLICT DO NOTHING;

-- Rôle d'administration système (portée TENANT) attribué à l'administrateur de démonstration
-- `dsi.admin` (continuum_user_id = 3333…). Porte toutes les fonctionnalités `admin.*` du catalogue, exigées par
-- l'autorisation fine (@PreAuthorize) des endpoints /api/admin.
INSERT INTO role (id, tenant_id, code, label, kind) VALUES
 ('c3333333-3333-3333-3333-333333333333', '11111111-1111-1111-1111-111111111111',
  'ADMIN_SYSTEME', '{"fr":"Administrateur Système"}', 'ORGANISATIONAL')
 ON CONFLICT DO NOTHING;
INSERT INTO role_feature (role_id, feature_code) VALUES
 ('c3333333-3333-3333-3333-333333333333', 'admin.alerts.manage'),
 ('c3333333-3333-3333-3333-333333333333', 'admin.assignment.manage'),
 ('c3333333-3333-3333-3333-333333333333', 'admin.assignment.read'),
 ('c3333333-3333-3333-3333-333333333333', 'admin.authz.simulate'),
 ('c3333333-3333-3333-3333-333333333333', 'admin.cache.evict'),
 ('c3333333-3333-3333-3333-333333333333', 'admin.cache.evict.all'),
 ('c3333333-3333-3333-3333-333333333333', 'admin.cache.read'),
 ('c3333333-3333-3333-3333-333333333333', 'admin.change.approve'),
 ('c3333333-3333-3333-3333-333333333333', 'admin.entity.manage'),
 ('c3333333-3333-3333-3333-333333333333', 'admin.entity.read'),
 ('c3333333-3333-3333-3333-333333333333', 'admin.logs.export'),
 ('c3333333-3333-3333-3333-333333333333', 'admin.logs.level.change'),
 ('c3333333-3333-3333-3333-333333333333', 'admin.logs.security.read'),
 ('c3333333-3333-3333-3333-333333333333', 'admin.logs.tech.read'),
 ('c3333333-3333-3333-3333-333333333333', 'admin.org.manage'),
 ('c3333333-3333-3333-3333-333333333333', 'admin.org.read'),
 ('c3333333-3333-3333-3333-333333333333', 'admin.overview.read'),
 ('c3333333-3333-3333-3333-333333333333', 'admin.position.manage'),
 ('c3333333-3333-3333-3333-333333333333', 'admin.position.read'),
 ('c3333333-3333-3333-3333-333333333333', 'admin.recertification.manage'),
 ('c3333333-3333-3333-3333-333333333333', 'admin.role.manage'),
 ('c3333333-3333-3333-3333-333333333333', 'admin.role.read'),
 ('c3333333-3333-3333-3333-333333333333', 'admin.sod.manage'),
 ('c3333333-3333-3333-3333-333333333333', 'admin.sod.read'),
 ('c3333333-3333-3333-3333-333333333333', 'admin.user.manage'),
 ('c3333333-3333-3333-3333-333333333333', 'admin.user.read'),
 ('c3333333-3333-3333-3333-333333333333', 'ops.connector.read'),
 ('c3333333-3333-3333-3333-333333333333', 'ops.connector.manage'),
 ('c3333333-3333-3333-3333-333333333333', 'ops.pack.manage'),
 ('c3333333-3333-3333-3333-333333333333', 'ops.theme.manage'),
 ('c3333333-3333-3333-3333-333333333333', 'ops.workflow.deploy'),
 ('c3333333-3333-3333-3333-333333333333', 'ops.workflow.operate'),
 ('c3333333-3333-3333-3333-333333333333', 'ops.health.read'),
 ('c3333333-3333-3333-3333-333333333333', 'ops.job.manage'),
 ('c3333333-3333-3333-3333-333333333333', 'ops.import.manage'),
 ('c3333333-3333-3333-3333-333333333333', 'ops.license.manage'),
 ('c3333333-3333-3333-3333-333333333333', 'ops.support.request'),
 ('c3333333-3333-3333-3333-333333333333', 'ops.ai.manage'),
 ('c3333333-3333-3333-3333-333333333333', 'ccm.read'),
 ('c3333333-3333-3333-3333-333333333333', 'ccm.population.explore'),
 ('c3333333-3333-3333-3333-333333333333', 'ccm.reconciliation.read')
 ON CONFLICT DO NOTHING;
INSERT INTO position (id, tenant_id, code, label, rank, scope) VALUES
 ('d3333333-3333-3333-3333-333333333333', '11111111-1111-1111-1111-111111111111',
  'ADMIN_SYSTEME', '{"fr":"Administrateur Système"}', 10, 'TENANT')
 ON CONFLICT DO NOTHING;
INSERT INTO position_role (position_id, role_id) VALUES
 ('d3333333-3333-3333-3333-333333333333', 'c3333333-3333-3333-3333-333333333333')
 ON CONFLICT DO NOTHING;
INSERT INTO assignment (id, tenant_id, user_id, position_id, org_unit_id, kind, valid_from) VALUES
 ('e3333333-3333-3333-3333-333333333333', '11111111-1111-1111-1111-111111111111',
  '33333333-3333-3333-3333-333333333333', 'd3333333-3333-3333-3333-333333333333',
  NULL, 'HOLDER', CURRENT_DATE)
 ON CONFLICT DO NOTHING;

-- Missions de démonstration (contrat app/missions.yaml), sur l'unité Inspection Générale ; visibles
-- par ig.demo (mission.read en portée UNIT_TREE). Libellés de référentiels inline (type/statut/phase).
INSERT INTO mission (id, tenant_id, org_unit_id, reference, title, mission_type_code, mission_type_label,
                     status_code, status_label, phase_code, phase_label, progress_percent, planned_start, planned_end) VALUES
 ('f1111111-1111-1111-1111-111111111101', '11111111-1111-1111-1111-111111111111', 'b1111111-1111-1111-1111-111111111111',
  'MIS-2026-INSP-014', 'Inspection agence A001', 'INSPECTION', 'Inspection',
  'EN_COURS', 'En cours', 'REALISATION', 'Réalisation', 40, DATE '2026-09-01', DATE '2026-11-30'),
 ('f1111111-1111-1111-1111-111111111102', '11111111-1111-1111-1111-111111111111', 'b1111111-1111-1111-1111-111111111111',
  'MIS-2026-AUDIT-007', 'Audit du processus crédit', 'AUDIT', 'Audit',
  'PLANIFIEE', 'Planifiée', 'PREPARATION', 'Préparation', 10, DATE '2026-10-15', DATE '2027-01-15'),
 ('f1111111-1111-1111-1111-111111111103', '11111111-1111-1111-1111-111111111111', 'b1111111-1111-1111-1111-111111111111',
  'MIS-2026-INSP-021', 'Revue conformité LCB-FT', 'INSPECTION', 'Inspection',
  'CLOTUREE', 'Clôturée', 'SUIVI', 'Suivi', 100, DATE '2026-05-02', DATE '2026-08-29')
 ON CONFLICT DO NOTHING;

-- Constats de démonstration (contrat app/findings.yaml), rattachés aux missions IG ; visibles par
-- ig.demo (finding.read en portée UNIT_TREE). Deux issus du CCM (cumul SoD, habilitation dormante).
INSERT INTO finding(id, tenant_id, mission_id, org_unit_id, reference, title, status_code, status_label,
                    criticality_code, criticality_label, source) VALUES
 ('a1110000-0000-0000-0000-000000000001', '11111111-1111-1111-1111-111111111111', 'f1111111-1111-1111-1111-111111111101',
  'b1111111-1111-1111-1111-111111111111', 'CST-2026-014-01', 'Cumul saisie/validation des virements (U003)',
  'OUVERT', 'Ouvert', 'HIGH', 'Élevée', 'CCM'),
 ('a1110000-0000-0000-0000-000000000002', '11111111-1111-1111-1111-111111111111', 'f1111111-1111-1111-1111-111111111101',
  'b1111111-1111-1111-1111-111111111111', 'CST-2026-014-02', 'Habilitation active pour un utilisateur désactivé (U004)',
  'OUVERT', 'Ouvert', 'MEDIUM', 'Moyenne', 'CCM'),
 ('a1110000-0000-0000-0000-000000000003', '11111111-1111-1111-1111-111111111111', 'f1111111-1111-1111-1111-111111111102',
  'b1111111-1111-1111-1111-111111111111', 'CST-2026-007-01', 'Procédure de crédit non formalisée',
  'EN_COURS', 'En cours', 'LOW', 'Faible', 'MANUAL')
 ON CONFLICT DO NOTHING;

-- Thème de démonstration (§1.6) : marque "Banque Démo" dérivée d'une couleur de marque (seed teal)
-- via Material 3 / HCT (le serveur en déduit toute la rampe --ct-* accessible), puis surcharge des
-- tokens primaires. Démontre apparence = donnée du tenant + dérivation M3 + priorité des surcharges.
INSERT INTO tenant_theme (tenant_id, tokens, version) VALUES
 ('11111111-1111-1111-1111-111111111111',
  '{"--ct-seed":"#0f766e","--ct-color-primary":"#0f766e","--ct-color-primary-hover":"#0b5c56","--ct-color-primary-soft":"#d6f3ef"}',
  2)
 ON CONFLICT (tenant_id) DO NOTHING;

-- FRAP du constat phare de démonstration (CCM cumul SoD) — §6.
UPDATE finding SET
  fact        = '3 virements (98 000 MAD) saisis ET validés par U003 en septembre 2026.',
  criterion   = 'Procédure virements §4.2 : double validation obligatoire.',
  cause        = 'U003 cumule saisie et validation depuis juillet 2024.',
  consequence = 'Risque de virement frauduleux non détecté.'
WHERE tenant_id = '11111111-1111-1111-1111-111111111111' AND reference = 'CST-2026-014-01';

-- Règle SoD statique bloquante (§2.2) : rédaction vs validation d'un constat. Le contrôle CCM (§5)
-- détecte tout utilisateur qui cumule ces deux fonctionnalités et en fait un constat.
INSERT INTO sod_rule (id, tenant_id, feature_a, feature_b, type, severity, from_pack) VALUES
 ('d0d00000-0000-0000-0000-000000000001', '11111111-1111-1111-1111-111111111111',
  'finding.write', 'finding.validate', 'STATIC', 'BLOCK', true)
 ON CONFLICT DO NOTHING;

-- Paramétrage des 3 contrôles CCM du pack (§5, CCM-03). Valeurs par défaut du pack ; modifiables par
-- écran. COMPTES-DORMANTS : excludeChannels vide volontairement pour que le mouvement de démo n°5
-- (canal BATCH, compte dormant A002000000003) ressorte — cf. QUESTIONS Q13.
INSERT INTO ccm_control (tenant_id, control_code, enabled, params) VALUES
 ('11111111-1111-1111-1111-111111111111', 'SOD-VIREMENTS', true,
  '{"makerFunction":"SAISIE_VIREMENT","checkerFunction":"VALIDATION_VIREMENT","transferOperationCodes":["VIR"]}'),
 ('11111111-1111-1111-1111-111111111111', 'SEUIL-HORAIRE', true,
  '{"thresholdAmount":1000000,"nonWorkingDays":["SAT","SUN"],"maxBackValueDays":2,"excludeChannels":["BATCH"]}'),
 ('11111111-1111-1111-1111-111111111111', 'COMPTES-DORMANTS', true,
  '{"dormancyMonths":12,"minAmount":10000,"excludeChannels":[],"largeOutflowAmount":100000}')
 ON CONFLICT (tenant_id, control_code) DO NOTHING;

-- Exceptions CCM à trier (§5.3, D34, contrat app/ccm.yaml) : le moteur produit des EXCEPTIONS (jamais
-- des constats). Statut NEW = non triées ; un auditeur les retient (→ constat candidat), les écarte ou
-- les affecte. Elles portent leur chaîne de preuve (enregistrement source du CBS, paramètres d'exécution).
-- Les deux constats source=CCM ci-dessus illustrent l'état APRÈS triage (exception retenue → constat).
INSERT INTO ccm_exception (id, tenant_id, control_code, org_unit_id, reference, title,
                           criticality_code, criticality_label, fact, criterion,
                           source_record, parameters_used, data_source) VALUES
 ('ce110000-0000-0000-0000-000000000001', '11111111-1111-1111-1111-111111111111', 'COMPTES-DORMANTS',
  'b1111111-1111-1111-1111-111111111111', 'CCM-DORM-5',
  'Mouvement sur compte dormant : 45000.00 MAD sur le compte A002000000003',
  'HIGH', 'Élevée',
  'Mouvement n°5 (D, 45000.00 MAD, canal BATCH) le 2026-09-05 sur le compte dormant A002000000003, validé par U004.',
  'Tout mouvement sur un compte dormant doit être justifié (LCB-FT, pack CCM-3).',
  '{"movementId":5,"accountId":"A002000000003","amount":"45000.00","direction":"D","channel":"BATCH","operationDate":"2026-09-05","validatedBy":"U004","triggerReason":"DORMANT"}'::jsonb,
  '{"dormancyMonths":12,"minAmount":"10000","largeOutflowAmount":"100000"}'::jsonb,
  'amplitude (JDBC, vues V_AUDIT_*)'),
 ('ce110000-0000-0000-0000-000000000002', '11111111-1111-1111-1111-111111111111', 'SEUIL-HORAIRE',
  'b1111111-1111-1111-1111-111111111111', 'CCM-OOB-4',
  'Écriture hors cadre (AMOUNT) : 2500000.00 MAD',
  'HIGH', 'Élevée',
  'Mouvement n°4 (2500000.00 MAD, canal GUICHET) le 2026-09-12 sur le compte A001000000002 — motif : AMOUNT.',
  'Opération hors seuil de délégation ou hors heures ouvrées (pack CCM-2).',
  '{"movementId":4,"accountId":"A001000000002","amount":"2500000.00","direction":"D","channel":"GUICHET","operationDate":"2026-09-12","triggerReason":"AMOUNT"}'::jsonb,
  '{"thresholdAmount":"1000000","maxBackValueDays":2}'::jsonb,
  'amplitude (JDBC, vues V_AUDIT_*)')
 ON CONFLICT (tenant_id, reference) DO NOTHING;

-- Comptes de démonstration (D40) : un par état, ig.demo = utilisateur du flux de connexion E2E.
INSERT INTO platform.user_account (id, tenant_id, username, source, status, mfa_configured, last_login) VALUES
 ('22222222-2222-2222-2222-222222222222', '11111111-1111-1111-1111-111111111111', 'ig.demo', 'LOCAL', 'ACTIVE', true, now()),
 ('22222222-2222-2222-2222-222222222223', '11111111-1111-1111-1111-111111111111', 'insp1.demo', 'AD', 'ACTIVE', false, now() - interval '2 days'),
 ('22222222-2222-2222-2222-222222222224', '11111111-1111-1111-1111-111111111111', 'locked.demo', 'AD', 'LOCKED', false, NULL),
 ('22222222-2222-2222-2222-222222222225', '11111111-1111-1111-1111-111111111111', 'disabled.demo', 'LOCAL', 'DISABLED', false, NULL),
 ('22222222-2222-2222-2222-222222222226', '11111111-1111-1111-1111-111111111111', 'noassign.demo', 'AD', 'NO_ASSIGNMENT', true, NULL),
 ('33333333-3333-3333-3333-333333333333', '11111111-1111-1111-1111-111111111111', 'dsi.admin', 'LOCAL', 'ACTIVE', true, now())
 ON CONFLICT (id) DO NOTHING;

-- État de synchronisation d'annuaire de démonstration (D37) : une source AD synchronisée, une jamais lancée.
INSERT INTO platform.directory_sync_state (id, tenant_id, source_code, last_sync_at, status, last_error, version) VALUES
 ('33333333-3333-3333-3333-333333333331', '11111111-1111-1111-1111-111111111111', 'AD', now() - interval '1 hour', 'SUCCESS', NULL, 0),
 ('33333333-3333-3333-3333-333333333332', '11111111-1111-1111-1111-111111111111', 'AD_BRANCHES', NULL, 'NEVER', NULL, 0)
 ON CONFLICT (id) DO NOTHING;

-- Politique de dépôt des preuves (ADR 0013) : valeurs par défaut du pack, ⟨à valider⟩ (QUESTIONS.md).
INSERT INTO evidence_policy (tenant_id, max_size_bytes, allowed_mime_types) VALUES
 ('11111111-1111-1111-1111-111111111111', 10485760, 'application/pdf,image/png,image/jpeg,text/plain')
 ON CONFLICT DO NOTHING;

-- Preuve de démonstration (D37) sur le constat phare CST-2026-014-01 (contenu BYTEA, sha256 calculé).
INSERT INTO evidence_content (tenant_id, storage_key, sha256, size_bytes, content)
SELECT '11111111-1111-1111-1111-111111111111', 'demo/CST-2026-014-01/extrait-virements.txt',
       encode(sha256(b), 'hex'), length(b), b
  FROM (SELECT convert_to('Extrait de demonstration : 3 virements saisis et valides par U003.', 'UTF8') AS b) t
 ON CONFLICT DO NOTHING;

INSERT INTO finding_evidence (id, tenant_id, finding_id, file_name, content_type, size_bytes, storage_key, uploaded_by) VALUES
 ('e1110000-0000-0000-0000-000000000001', '11111111-1111-1111-1111-111111111111', 'a1110000-0000-0000-0000-000000000001',
  'extrait-virements.txt', 'text/plain',
  (SELECT size_bytes FROM evidence_content WHERE storage_key = 'demo/CST-2026-014-01/extrait-virements.txt'),
  'demo/CST-2026-014-01/extrait-virements.txt', '22222222-2222-2222-2222-222222222222')
 ON CONFLICT DO NOTHING;

-- Run CCM de démonstration (§5, contrat app/ccm.yaml CcmRun) : un passage réussi du contrôle COMPTES-DORMANTS
-- ayant produit l'exception CCM-DORM-5. Sert au contrôle live de /ccm/runs/{runId}.
INSERT INTO ccm_run (id, tenant_id, control_code, status, trigger_type, started_at, finished_at,
                     population_size, exceptions_count, data_source, parameters_used) VALUES
 ('cc110000-0000-0000-0000-000000000001', '11111111-1111-1111-1111-111111111111', 'COMPTES-DORMANTS',
  'SUCCEEDED', 'MANUAL', now() - interval '1 hour', now() - interval '59 minutes', 3, 1,
  'amplitude (JDBC, vues V_AUDIT_*)',
  '{"dormancyMonths":12,"minAmount":"10000","largeOutflowAmount":"100000"}'::jsonb)
 ON CONFLICT (id) DO NOTHING;

-- Couverture complète du cycle de triage CCM (D37, §5.3) : runs + exceptions dans TOUS les statuts, liées
-- à leur run, à leur mission et (après conversion) à leur constat. Idempotent (UPDATE ciblés + ON CONFLICT).
INSERT INTO ccm_run (id, tenant_id, control_code, status, trigger_type, started_at, finished_at,
                     population_size, exceptions_count, data_source, parameters_used) VALUES
 ('cc110000-0000-0000-0000-000000000002', '11111111-1111-1111-1111-111111111111', 'SEUIL-HORAIRE',
  'SUCCEEDED', 'SCHEDULE', now() - interval '1 day 1 hour', now() - interval '1 day 59 minutes', 5, 2,
  'amplitude (JDBC, vues V_AUDIT_*)', '{"thresholdAmount":"1000000","maxBackValueDays":2}'::jsonb),
 ('cc110000-0000-0000-0000-000000000003', '11111111-1111-1111-1111-111111111111', 'SOD-VIREMENTS',
  'SUCCEEDED', 'SCHEDULE', now() - interval '2 days', now() - interval '2 days' + interval '1 minute', NULL, 2,
  'amplitude (JDBC, vues V_AUDIT_*)', '{"makerFunction":"SAISIE_VIREMENT","checkerFunction":"VALIDATION_VIREMENT"}'::jsonb)
 ON CONFLICT (id) DO NOTHING;

INSERT INTO ccm_exception (id, tenant_id, control_code, org_unit_id, reference, title, criticality_code, criticality_label,
                           status_code, status_label, fact, criterion, source_record, parameters_used, data_source,
                           run_id, mission_id, finding_id, dismissal_justification, triaged_by, triaged_at) VALUES
 ('ce110000-0000-0000-0000-000000000003', '11111111-1111-1111-1111-111111111111', 'SEUIL-HORAIRE',
  'b1111111-1111-1111-1111-111111111111', 'CCM-OOB-7',
  'Écriture hors cadre (WEEKEND) : 18000.00 MAD', 'LOW', 'Faible', 'DISCARDED', 'Écartée',
  'Mouvement n°7 (18000.00 MAD, canal GUICHET) le 2026-09-19 (samedi) sur le compte A001000000001.',
  'Opération hors seuil de délégation ou hors heures ouvrées (pack CCM-2).',
  '{"movementId":7,"accountId":"A001000000001","amount":"18000.00","direction":"D","channel":"GUICHET","operationDate":"2026-09-19","triggerReason":"WEEKEND"}'::jsonb,
  '{"thresholdAmount":"1000000","maxBackValueDays":2}'::jsonb, 'amplitude (JDBC, vues V_AUDIT_*)',
  'cc110000-0000-0000-0000-000000000002', NULL, NULL,
  'Ouverture exceptionnelle de l''agence le samedi, autorisée par la direction régionale (note DR-2026-118).',
  '22222222-2222-2222-2222-222222222222', now() - interval '20 hours'),
 ('ce110000-0000-0000-0000-000000000004', '11111111-1111-1111-1111-111111111111', 'SOD-VIREMENTS',
  'b1111111-1111-1111-1111-111111111111', 'CCM-SOD-U003',
  'Cumul saisie/validation des virements (U003)', 'HIGH', 'Élevée', 'CONVERTED', 'Convertie en constat',
  '3 virements (98 000 MAD) saisis ET validés par U003 en septembre 2026.',
  'Procédure virements §4.2 : double validation obligatoire.',
  '{"userId":"U003","movementIds":[1,2,3],"enteredBy":"U003","validatedBy":"U003"}'::jsonb,
  '{"makerFunction":"SAISIE_VIREMENT","checkerFunction":"VALIDATION_VIREMENT"}'::jsonb, 'amplitude (JDBC, vues V_AUDIT_*)',
  'cc110000-0000-0000-0000-000000000003', 'f1111111-1111-1111-1111-111111111101', 'a1110000-0000-0000-0000-000000000001', NULL,
  '22222222-2222-2222-2222-222222222222', now() - interval '1 day'),
 ('ce110000-0000-0000-0000-000000000005', '11111111-1111-1111-1111-111111111111', 'SOD-VIREMENTS',
  'b1111111-1111-1111-1111-111111111111', 'CCM-SOD-U004',
  'Habilitation active pour un utilisateur désactivé (U004)', 'MEDIUM', 'Moyenne', 'CONVERTED', 'Convertie en constat',
  'Utilisateur U004 désactivé mais habilitation de validation des virements toujours active.',
  'Revue périodique des habilitations (pack CCM-1).',
  '{"userId":"U004","enteredBy":null,"validatedBy":"U004"}'::jsonb,
  '{"makerFunction":"SAISIE_VIREMENT","checkerFunction":"VALIDATION_VIREMENT"}'::jsonb, 'amplitude (JDBC, vues V_AUDIT_*)',
  'cc110000-0000-0000-0000-000000000003', 'f1111111-1111-1111-1111-111111111101', 'a1110000-0000-0000-0000-000000000002', NULL,
  '22222222-2222-2222-2222-222222222222', now() - interval '1 day')
 ON CONFLICT (tenant_id, reference) DO NOTHING;

-- NEW : rattachée à son run ; RETAINED : rattachée au run et à la mission retenue, pas encore convertie.
UPDATE ccm_exception SET run_id = 'cc110000-0000-0000-0000-000000000001'
 WHERE id = 'ce110000-0000-0000-0000-000000000001' AND run_id IS NULL;
UPDATE ccm_exception SET run_id = 'cc110000-0000-0000-0000-000000000002',
       mission_id = 'f1111111-1111-1111-1111-111111111101', status_code = 'RETAINED', status_label = 'Retenue',
       triaged_by = '22222222-2222-2222-2222-222222222222', triaged_at = now() - interval '2 hours'
 WHERE id = 'ce110000-0000-0000-0000-000000000002' AND run_id IS NULL;

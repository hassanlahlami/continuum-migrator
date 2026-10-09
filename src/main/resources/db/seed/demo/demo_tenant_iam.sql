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
 ('11111111-1111-1111-1111-111111111111', 'ADMIN', true)
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
 ('c1111111-1111-1111-1111-111111111111', 'finding.write')
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
-- `dsi.admin` (continuum_user_id = 3333…). Porte les fonctionnalités d'écriture admin exigées par
-- l'autorisation fine (@PreAuthorize) des endpoints /api/admin : gestion des affectations et des rôles.
INSERT INTO role (id, tenant_id, code, label, kind) VALUES
 ('c3333333-3333-3333-3333-333333333333', '11111111-1111-1111-1111-111111111111',
  'ADMIN_SYSTEME', '{"fr":"Administrateur Système"}', 'ORGANISATIONAL')
 ON CONFLICT DO NOTHING;
INSERT INTO role_feature (role_id, feature_code) VALUES
 ('c3333333-3333-3333-3333-333333333333', 'admin.assignment.manage'),
 ('c3333333-3333-3333-3333-333333333333', 'admin.role.manage')
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

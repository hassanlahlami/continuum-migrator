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
 ('11111111-1111-1111-1111-111111111111', 'FINDING', true)
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

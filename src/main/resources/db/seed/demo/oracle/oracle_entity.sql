-- Jeu de démonstration (D37, §8.7) — équivalent Oracle de seed/demo/demo_tenant_iam.sql, PASSE ENTITÉ.
-- À exécuter sous l'utilisateur de l'entité (CONTINUUM), APRÈS oracle_platform.sql. Rejouable (NOT EXISTS sur la PK).
-- Écart Oracle : pas de colonne org_unit.path → ligne propre dans org_unit_closure (ancêtre = descendant, depth 0).

INSERT INTO org_unit_type (id, tenant_id, code, label, depth)
SELECT HEXTORAW('a1111111111111111111111111111111'), HEXTORAW('11111111111111111111111111111111'), 'DIR', '{"fr":"Direction"}', 1 FROM dual
 WHERE NOT EXISTS (SELECT 1 FROM org_unit_type WHERE id = HEXTORAW('a1111111111111111111111111111111'));

INSERT INTO org_unit (id, tenant_id, type_id, parent_id, code, label)
SELECT HEXTORAW('b1111111111111111111111111111111'), HEXTORAW('11111111111111111111111111111111'), HEXTORAW('a1111111111111111111111111111111'), NULL, 'IG', '{"fr":"Inspection Générale"}' FROM dual
 WHERE NOT EXISTS (SELECT 1 FROM org_unit WHERE id = HEXTORAW('b1111111111111111111111111111111'));

INSERT INTO org_unit_closure (ancestor_id, descendant_id, depth)
SELECT HEXTORAW('b1111111111111111111111111111111'), HEXTORAW('b1111111111111111111111111111111'), 0 FROM dual
 WHERE NOT EXISTS (SELECT 1 FROM org_unit_closure WHERE ancestor_id = HEXTORAW('b1111111111111111111111111111111') AND descendant_id = HEXTORAW('b1111111111111111111111111111111'));

INSERT INTO role (id, tenant_id, code, label, kind)
SELECT HEXTORAW('c1111111111111111111111111111111'), HEXTORAW('11111111111111111111111111111111'), 'INSPECTEUR', '{"fr":"Inspecteur"}', 'ORGANISATIONAL' FROM dual
 WHERE NOT EXISTS (SELECT 1 FROM role WHERE id = HEXTORAW('c1111111111111111111111111111111'));

INSERT INTO role_feature (role_id, feature_code)
SELECT HEXTORAW('c1111111111111111111111111111111'), 'mission.read' FROM dual
 WHERE NOT EXISTS (SELECT 1 FROM role_feature WHERE role_id = HEXTORAW('c1111111111111111111111111111111') AND feature_code = 'mission.read');

INSERT INTO role_feature (role_id, feature_code)
SELECT HEXTORAW('c1111111111111111111111111111111'), 'finding.read' FROM dual
 WHERE NOT EXISTS (SELECT 1 FROM role_feature WHERE role_id = HEXTORAW('c1111111111111111111111111111111') AND feature_code = 'finding.read');

INSERT INTO role_feature (role_id, feature_code)
SELECT HEXTORAW('c1111111111111111111111111111111'), 'finding.write' FROM dual
 WHERE NOT EXISTS (SELECT 1 FROM role_feature WHERE role_id = HEXTORAW('c1111111111111111111111111111111') AND feature_code = 'finding.write');

INSERT INTO role_feature (role_id, feature_code)
SELECT HEXTORAW('c1111111111111111111111111111111'), 'ccm.read' FROM dual
 WHERE NOT EXISTS (SELECT 1 FROM role_feature WHERE role_id = HEXTORAW('c1111111111111111111111111111111') AND feature_code = 'ccm.read');

INSERT INTO position (id, tenant_id, code, label, rank, scope)
SELECT HEXTORAW('d1111111111111111111111111111111'), HEXTORAW('11111111111111111111111111111111'), 'INSPECTEUR', '{"fr":"Inspecteur"}', 30, 'UNIT_TREE' FROM dual
 WHERE NOT EXISTS (SELECT 1 FROM position WHERE id = HEXTORAW('d1111111111111111111111111111111'));

INSERT INTO position_role (position_id, role_id)
SELECT HEXTORAW('d1111111111111111111111111111111'), HEXTORAW('c1111111111111111111111111111111') FROM dual
 WHERE NOT EXISTS (SELECT 1 FROM position_role WHERE position_id = HEXTORAW('d1111111111111111111111111111111') AND role_id = HEXTORAW('c1111111111111111111111111111111'));

INSERT INTO role (id, tenant_id, code, label, kind)
SELECT HEXTORAW('c2222222222222222222222222222222'), HEXTORAW('11111111111111111111111111111111'), 'VALIDATEUR', '{"fr":"Valideur de constats"}', 'ORGANISATIONAL' FROM dual
 WHERE NOT EXISTS (SELECT 1 FROM role WHERE id = HEXTORAW('c2222222222222222222222222222222'));

INSERT INTO role_feature (role_id, feature_code)
SELECT HEXTORAW('c2222222222222222222222222222222'), 'finding.validate' FROM dual
 WHERE NOT EXISTS (SELECT 1 FROM role_feature WHERE role_id = HEXTORAW('c2222222222222222222222222222222') AND feature_code = 'finding.validate');

INSERT INTO position (id, tenant_id, code, label, rank, scope)
SELECT HEXTORAW('d2222222222222222222222222222222'), HEXTORAW('11111111111111111111111111111111'), 'VALIDATEUR', '{"fr":"Valideur de constats"}', 40, 'UNIT_TREE' FROM dual
 WHERE NOT EXISTS (SELECT 1 FROM position WHERE id = HEXTORAW('d2222222222222222222222222222222'));

INSERT INTO position_role (position_id, role_id)
SELECT HEXTORAW('d2222222222222222222222222222222'), HEXTORAW('c2222222222222222222222222222222') FROM dual
 WHERE NOT EXISTS (SELECT 1 FROM position_role WHERE position_id = HEXTORAW('d2222222222222222222222222222222') AND role_id = HEXTORAW('c2222222222222222222222222222222'));

INSERT INTO role (id, tenant_id, code, label, kind)
SELECT HEXTORAW('c3333333333333333333333333333333'), HEXTORAW('11111111111111111111111111111111'), 'ADMIN_SYSTEME', '{"fr":"Administrateur Système"}', 'ORGANISATIONAL' FROM dual
 WHERE NOT EXISTS (SELECT 1 FROM role WHERE id = HEXTORAW('c3333333333333333333333333333333'));

INSERT INTO role_feature (role_id, feature_code)
SELECT HEXTORAW('c3333333333333333333333333333333'), 'admin.alerts.manage' FROM dual
 WHERE NOT EXISTS (SELECT 1 FROM role_feature WHERE role_id = HEXTORAW('c3333333333333333333333333333333') AND feature_code = 'admin.alerts.manage');

INSERT INTO role_feature (role_id, feature_code)
SELECT HEXTORAW('c3333333333333333333333333333333'), 'admin.assignment.manage' FROM dual
 WHERE NOT EXISTS (SELECT 1 FROM role_feature WHERE role_id = HEXTORAW('c3333333333333333333333333333333') AND feature_code = 'admin.assignment.manage');

INSERT INTO role_feature (role_id, feature_code)
SELECT HEXTORAW('c3333333333333333333333333333333'), 'admin.assignment.read' FROM dual
 WHERE NOT EXISTS (SELECT 1 FROM role_feature WHERE role_id = HEXTORAW('c3333333333333333333333333333333') AND feature_code = 'admin.assignment.read');

INSERT INTO role_feature (role_id, feature_code)
SELECT HEXTORAW('c3333333333333333333333333333333'), 'admin.authz.simulate' FROM dual
 WHERE NOT EXISTS (SELECT 1 FROM role_feature WHERE role_id = HEXTORAW('c3333333333333333333333333333333') AND feature_code = 'admin.authz.simulate');

INSERT INTO role_feature (role_id, feature_code)
SELECT HEXTORAW('c3333333333333333333333333333333'), 'admin.cache.evict' FROM dual
 WHERE NOT EXISTS (SELECT 1 FROM role_feature WHERE role_id = HEXTORAW('c3333333333333333333333333333333') AND feature_code = 'admin.cache.evict');

INSERT INTO role_feature (role_id, feature_code)
SELECT HEXTORAW('c3333333333333333333333333333333'), 'admin.cache.evict.all' FROM dual
 WHERE NOT EXISTS (SELECT 1 FROM role_feature WHERE role_id = HEXTORAW('c3333333333333333333333333333333') AND feature_code = 'admin.cache.evict.all');

INSERT INTO role_feature (role_id, feature_code)
SELECT HEXTORAW('c3333333333333333333333333333333'), 'admin.cache.read' FROM dual
 WHERE NOT EXISTS (SELECT 1 FROM role_feature WHERE role_id = HEXTORAW('c3333333333333333333333333333333') AND feature_code = 'admin.cache.read');

INSERT INTO role_feature (role_id, feature_code)
SELECT HEXTORAW('c3333333333333333333333333333333'), 'admin.change.approve' FROM dual
 WHERE NOT EXISTS (SELECT 1 FROM role_feature WHERE role_id = HEXTORAW('c3333333333333333333333333333333') AND feature_code = 'admin.change.approve');

INSERT INTO role_feature (role_id, feature_code)
SELECT HEXTORAW('c3333333333333333333333333333333'), 'admin.entity.manage' FROM dual
 WHERE NOT EXISTS (SELECT 1 FROM role_feature WHERE role_id = HEXTORAW('c3333333333333333333333333333333') AND feature_code = 'admin.entity.manage');

INSERT INTO role_feature (role_id, feature_code)
SELECT HEXTORAW('c3333333333333333333333333333333'), 'admin.entity.read' FROM dual
 WHERE NOT EXISTS (SELECT 1 FROM role_feature WHERE role_id = HEXTORAW('c3333333333333333333333333333333') AND feature_code = 'admin.entity.read');

INSERT INTO role_feature (role_id, feature_code)
SELECT HEXTORAW('c3333333333333333333333333333333'), 'admin.logs.export' FROM dual
 WHERE NOT EXISTS (SELECT 1 FROM role_feature WHERE role_id = HEXTORAW('c3333333333333333333333333333333') AND feature_code = 'admin.logs.export');

INSERT INTO role_feature (role_id, feature_code)
SELECT HEXTORAW('c3333333333333333333333333333333'), 'admin.logs.level.change' FROM dual
 WHERE NOT EXISTS (SELECT 1 FROM role_feature WHERE role_id = HEXTORAW('c3333333333333333333333333333333') AND feature_code = 'admin.logs.level.change');

INSERT INTO role_feature (role_id, feature_code)
SELECT HEXTORAW('c3333333333333333333333333333333'), 'admin.logs.security.read' FROM dual
 WHERE NOT EXISTS (SELECT 1 FROM role_feature WHERE role_id = HEXTORAW('c3333333333333333333333333333333') AND feature_code = 'admin.logs.security.read');

INSERT INTO role_feature (role_id, feature_code)
SELECT HEXTORAW('c3333333333333333333333333333333'), 'admin.logs.tech.read' FROM dual
 WHERE NOT EXISTS (SELECT 1 FROM role_feature WHERE role_id = HEXTORAW('c3333333333333333333333333333333') AND feature_code = 'admin.logs.tech.read');

INSERT INTO role_feature (role_id, feature_code)
SELECT HEXTORAW('c3333333333333333333333333333333'), 'admin.org.manage' FROM dual
 WHERE NOT EXISTS (SELECT 1 FROM role_feature WHERE role_id = HEXTORAW('c3333333333333333333333333333333') AND feature_code = 'admin.org.manage');

INSERT INTO role_feature (role_id, feature_code)
SELECT HEXTORAW('c3333333333333333333333333333333'), 'admin.org.read' FROM dual
 WHERE NOT EXISTS (SELECT 1 FROM role_feature WHERE role_id = HEXTORAW('c3333333333333333333333333333333') AND feature_code = 'admin.org.read');

INSERT INTO role_feature (role_id, feature_code)
SELECT HEXTORAW('c3333333333333333333333333333333'), 'admin.overview.read' FROM dual
 WHERE NOT EXISTS (SELECT 1 FROM role_feature WHERE role_id = HEXTORAW('c3333333333333333333333333333333') AND feature_code = 'admin.overview.read');

INSERT INTO role_feature (role_id, feature_code)
SELECT HEXTORAW('c3333333333333333333333333333333'), 'admin.position.manage' FROM dual
 WHERE NOT EXISTS (SELECT 1 FROM role_feature WHERE role_id = HEXTORAW('c3333333333333333333333333333333') AND feature_code = 'admin.position.manage');

INSERT INTO role_feature (role_id, feature_code)
SELECT HEXTORAW('c3333333333333333333333333333333'), 'admin.position.read' FROM dual
 WHERE NOT EXISTS (SELECT 1 FROM role_feature WHERE role_id = HEXTORAW('c3333333333333333333333333333333') AND feature_code = 'admin.position.read');

INSERT INTO role_feature (role_id, feature_code)
SELECT HEXTORAW('c3333333333333333333333333333333'), 'admin.recertification.manage' FROM dual
 WHERE NOT EXISTS (SELECT 1 FROM role_feature WHERE role_id = HEXTORAW('c3333333333333333333333333333333') AND feature_code = 'admin.recertification.manage');

INSERT INTO role_feature (role_id, feature_code)
SELECT HEXTORAW('c3333333333333333333333333333333'), 'admin.role.manage' FROM dual
 WHERE NOT EXISTS (SELECT 1 FROM role_feature WHERE role_id = HEXTORAW('c3333333333333333333333333333333') AND feature_code = 'admin.role.manage');

INSERT INTO role_feature (role_id, feature_code)
SELECT HEXTORAW('c3333333333333333333333333333333'), 'admin.role.read' FROM dual
 WHERE NOT EXISTS (SELECT 1 FROM role_feature WHERE role_id = HEXTORAW('c3333333333333333333333333333333') AND feature_code = 'admin.role.read');

INSERT INTO role_feature (role_id, feature_code)
SELECT HEXTORAW('c3333333333333333333333333333333'), 'admin.sod.manage' FROM dual
 WHERE NOT EXISTS (SELECT 1 FROM role_feature WHERE role_id = HEXTORAW('c3333333333333333333333333333333') AND feature_code = 'admin.sod.manage');

INSERT INTO role_feature (role_id, feature_code)
SELECT HEXTORAW('c3333333333333333333333333333333'), 'admin.sod.read' FROM dual
 WHERE NOT EXISTS (SELECT 1 FROM role_feature WHERE role_id = HEXTORAW('c3333333333333333333333333333333') AND feature_code = 'admin.sod.read');

INSERT INTO role_feature (role_id, feature_code)
SELECT HEXTORAW('c3333333333333333333333333333333'), 'admin.user.manage' FROM dual
 WHERE NOT EXISTS (SELECT 1 FROM role_feature WHERE role_id = HEXTORAW('c3333333333333333333333333333333') AND feature_code = 'admin.user.manage');

INSERT INTO role_feature (role_id, feature_code)
SELECT HEXTORAW('c3333333333333333333333333333333'), 'admin.user.read' FROM dual
 WHERE NOT EXISTS (SELECT 1 FROM role_feature WHERE role_id = HEXTORAW('c3333333333333333333333333333333') AND feature_code = 'admin.user.read');

INSERT INTO position (id, tenant_id, code, label, rank, scope)
SELECT HEXTORAW('d3333333333333333333333333333333'), HEXTORAW('11111111111111111111111111111111'), 'ADMIN_SYSTEME', '{"fr":"Administrateur Système"}', 10, 'TENANT' FROM dual
 WHERE NOT EXISTS (SELECT 1 FROM position WHERE id = HEXTORAW('d3333333333333333333333333333333'));

INSERT INTO position_role (position_id, role_id)
SELECT HEXTORAW('d3333333333333333333333333333333'), HEXTORAW('c3333333333333333333333333333333') FROM dual
 WHERE NOT EXISTS (SELECT 1 FROM position_role WHERE position_id = HEXTORAW('d3333333333333333333333333333333') AND role_id = HEXTORAW('c3333333333333333333333333333333'));

INSERT INTO assignment (id, tenant_id, user_id, position_id, org_unit_id, kind, valid_from)
SELECT HEXTORAW('e1111111111111111111111111111111'), HEXTORAW('11111111111111111111111111111111'), HEXTORAW('22222222222222222222222222222222'), HEXTORAW('d1111111111111111111111111111111'), HEXTORAW('b1111111111111111111111111111111'), 'HOLDER', TRUNC(SYSDATE) FROM dual
 WHERE NOT EXISTS (SELECT 1 FROM assignment WHERE id = HEXTORAW('e1111111111111111111111111111111'));

INSERT INTO assignment (id, tenant_id, user_id, position_id, org_unit_id, kind, valid_from)
SELECT HEXTORAW('e3333333333333333333333333333333'), HEXTORAW('11111111111111111111111111111111'), HEXTORAW('33333333333333333333333333333333'), HEXTORAW('d3333333333333333333333333333333'), NULL, 'HOLDER', TRUNC(SYSDATE) FROM dual
 WHERE NOT EXISTS (SELECT 1 FROM assignment WHERE id = HEXTORAW('e3333333333333333333333333333333'));

INSERT INTO mission (id, tenant_id, org_unit_id, reference, title, mission_type_code, mission_type_label, status_code, status_label, phase_code, phase_label, progress_percent, planned_start, planned_end)
SELECT HEXTORAW('f1111111111111111111111111111101'), HEXTORAW('11111111111111111111111111111111'), HEXTORAW('b1111111111111111111111111111111'), 'MIS-2026-INSP-014', 'Inspection agence A001', 'INSPECTION', 'Inspection', 'EN_COURS', 'En cours', 'REALISATION', 'Réalisation', 40, DATE '2026-09-01', DATE '2026-11-30' FROM dual
 WHERE NOT EXISTS (SELECT 1 FROM mission WHERE id = HEXTORAW('f1111111111111111111111111111101'));

INSERT INTO mission (id, tenant_id, org_unit_id, reference, title, mission_type_code, mission_type_label, status_code, status_label, phase_code, phase_label, progress_percent, planned_start, planned_end)
SELECT HEXTORAW('f1111111111111111111111111111102'), HEXTORAW('11111111111111111111111111111111'), HEXTORAW('b1111111111111111111111111111111'), 'MIS-2026-AUDIT-007', 'Audit du processus crédit', 'AUDIT', 'Audit', 'PLANIFIEE', 'Planifiée', 'PREPARATION', 'Préparation', 10, DATE '2026-10-15', DATE '2027-01-15' FROM dual
 WHERE NOT EXISTS (SELECT 1 FROM mission WHERE id = HEXTORAW('f1111111111111111111111111111102'));

INSERT INTO mission (id, tenant_id, org_unit_id, reference, title, mission_type_code, mission_type_label, status_code, status_label, phase_code, phase_label, progress_percent, planned_start, planned_end)
SELECT HEXTORAW('f1111111111111111111111111111103'), HEXTORAW('11111111111111111111111111111111'), HEXTORAW('b1111111111111111111111111111111'), 'MIS-2026-INSP-021', 'Revue conformité LCB-FT', 'INSPECTION', 'Inspection', 'CLOTUREE', 'Clôturée', 'SUIVI', 'Suivi', 100, DATE '2026-05-02', DATE '2026-08-29' FROM dual
 WHERE NOT EXISTS (SELECT 1 FROM mission WHERE id = HEXTORAW('f1111111111111111111111111111103'));

INSERT INTO finding (id, tenant_id, mission_id, org_unit_id, reference, title, status_code, status_label, criticality_code, criticality_label, source)
SELECT HEXTORAW('a1110000000000000000000000000001'), HEXTORAW('11111111111111111111111111111111'), HEXTORAW('f1111111111111111111111111111101'), HEXTORAW('b1111111111111111111111111111111'), 'CST-2026-014-01', 'Cumul saisie/validation des virements (U003)', 'OUVERT', 'Ouvert', 'HIGH', 'Élevée', 'CCM' FROM dual
 WHERE NOT EXISTS (SELECT 1 FROM finding WHERE id = HEXTORAW('a1110000000000000000000000000001'));

INSERT INTO finding (id, tenant_id, mission_id, org_unit_id, reference, title, status_code, status_label, criticality_code, criticality_label, source)
SELECT HEXTORAW('a1110000000000000000000000000002'), HEXTORAW('11111111111111111111111111111111'), HEXTORAW('f1111111111111111111111111111101'), HEXTORAW('b1111111111111111111111111111111'), 'CST-2026-014-02', 'Habilitation active pour un utilisateur désactivé (U004)', 'OUVERT', 'Ouvert', 'MEDIUM', 'Moyenne', 'CCM' FROM dual
 WHERE NOT EXISTS (SELECT 1 FROM finding WHERE id = HEXTORAW('a1110000000000000000000000000002'));

INSERT INTO finding (id, tenant_id, mission_id, org_unit_id, reference, title, status_code, status_label, criticality_code, criticality_label, source)
SELECT HEXTORAW('a1110000000000000000000000000003'), HEXTORAW('11111111111111111111111111111111'), HEXTORAW('f1111111111111111111111111111102'), HEXTORAW('b1111111111111111111111111111111'), 'CST-2026-007-01', 'Procédure de crédit non formalisée', 'EN_COURS', 'En cours', 'LOW', 'Faible', 'MANUAL' FROM dual
 WHERE NOT EXISTS (SELECT 1 FROM finding WHERE id = HEXTORAW('a1110000000000000000000000000003'));

INSERT INTO tenant_theme (tenant_id, tokens, version)
SELECT HEXTORAW('11111111111111111111111111111111'), '{"--ct-seed":"#0f766e","--ct-color-primary":"#0f766e","--ct-color-primary-hover":"#0b5c56","--ct-color-primary-soft":"#d6f3ef"}', 2 FROM dual
 WHERE NOT EXISTS (SELECT 1 FROM tenant_theme WHERE tenant_id = HEXTORAW('11111111111111111111111111111111'));

UPDATE finding SET
  fact        = '3 virements (98 000 MAD) saisis ET validés par U003 en septembre 2026.',
  criterion   = 'Procédure virements §4.2 : double validation obligatoire.',
  cause       = 'U003 cumule saisie et validation depuis juillet 2024.',
  consequence = 'Risque de virement frauduleux non détecté.'
WHERE tenant_id = HEXTORAW('11111111111111111111111111111111') AND reference = 'CST-2026-014-01';

INSERT INTO sod_rule (id, tenant_id, feature_a, feature_b, type, severity, from_pack)
SELECT HEXTORAW('d0d00000000000000000000000000001'), HEXTORAW('11111111111111111111111111111111'), 'finding.write', 'finding.validate', 'STATIC', 'BLOCK', 1 FROM dual
 WHERE NOT EXISTS (SELECT 1 FROM sod_rule WHERE id = HEXTORAW('d0d00000000000000000000000000001'));

INSERT INTO ccm_control (tenant_id, control_code, enabled, params)
SELECT HEXTORAW('11111111111111111111111111111111'), 'SOD-VIREMENTS', 1, '{"makerFunction":"SAISIE_VIREMENT","checkerFunction":"VALIDATION_VIREMENT","transferOperationCodes":["VIR"]}' FROM dual
 WHERE NOT EXISTS (SELECT 1 FROM ccm_control WHERE tenant_id = HEXTORAW('11111111111111111111111111111111') AND control_code = 'SOD-VIREMENTS');

INSERT INTO ccm_control (tenant_id, control_code, enabled, params)
SELECT HEXTORAW('11111111111111111111111111111111'), 'SEUIL-HORAIRE', 1, '{"thresholdAmount":1000000,"nonWorkingDays":["SAT","SUN"],"maxBackValueDays":2,"excludeChannels":["BATCH"]}' FROM dual
 WHERE NOT EXISTS (SELECT 1 FROM ccm_control WHERE tenant_id = HEXTORAW('11111111111111111111111111111111') AND control_code = 'SEUIL-HORAIRE');

INSERT INTO ccm_control (tenant_id, control_code, enabled, params)
SELECT HEXTORAW('11111111111111111111111111111111'), 'COMPTES-DORMANTS', 1, '{"dormancyMonths":12,"minAmount":10000,"excludeChannels":[],"largeOutflowAmount":100000}' FROM dual
 WHERE NOT EXISTS (SELECT 1 FROM ccm_control WHERE tenant_id = HEXTORAW('11111111111111111111111111111111') AND control_code = 'COMPTES-DORMANTS');

INSERT INTO ccm_exception (id, tenant_id, control_code, org_unit_id, reference, title, criticality_code, criticality_label, fact, criterion, source_record, parameters_used, data_source)
SELECT HEXTORAW('ce110000000000000000000000000001'), HEXTORAW('11111111111111111111111111111111'), 'COMPTES-DORMANTS', HEXTORAW('b1111111111111111111111111111111'), 'CCM-DORM-5', 'Mouvement sur compte dormant : 45000.00 MAD sur le compte A002000000003', 'HIGH', 'Élevée', 'Mouvement n°5 (D, 45000.00 MAD, canal BATCH) le 2026-09-05 sur le compte dormant A002000000003, validé par U004.', 'Tout mouvement sur un compte dormant doit être justifié (LCB-FT, pack CCM-3).', '{"movementId":5,"accountId":"A002000000003","amount":"45000.00","direction":"D","channel":"BATCH","operationDate":"2026-09-05","validatedBy":"U004","triggerReason":"DORMANT"}', '{"dormancyMonths":12,"minAmount":"10000","largeOutflowAmount":"100000"}', 'amplitude (JDBC, vues V_AUDIT_*)' FROM dual
 WHERE NOT EXISTS (SELECT 1 FROM ccm_exception WHERE id = HEXTORAW('ce110000000000000000000000000001'));

INSERT INTO ccm_exception (id, tenant_id, control_code, org_unit_id, reference, title, criticality_code, criticality_label, fact, criterion, source_record, parameters_used, data_source)
SELECT HEXTORAW('ce110000000000000000000000000002'), HEXTORAW('11111111111111111111111111111111'), 'SEUIL-HORAIRE', HEXTORAW('b1111111111111111111111111111111'), 'CCM-OOB-4', 'Écriture hors cadre (AMOUNT) : 2500000.00 MAD', 'HIGH', 'Élevée', 'Mouvement n°4 (2500000.00 MAD, canal GUICHET) le 2026-09-12 sur le compte A001000000002 — motif : AMOUNT.', 'Opération hors seuil de délégation ou hors heures ouvrées (pack CCM-2).', '{"movementId":4,"accountId":"A001000000002","amount":"2500000.00","direction":"D","channel":"GUICHET","operationDate":"2026-09-12","triggerReason":"AMOUNT"}', '{"thresholdAmount":"1000000","maxBackValueDays":2}', 'amplitude (JDBC, vues V_AUDIT_*)' FROM dual
 WHERE NOT EXISTS (SELECT 1 FROM ccm_exception WHERE id = HEXTORAW('ce110000000000000000000000000002'));

-- Politique de dépôt des preuves (ADR 0013) : défauts du pack, ⟨à valider⟩ (QUESTIONS.md).
INSERT INTO evidence_policy (tenant_id, max_size_bytes, allowed_mime_types)
SELECT HEXTORAW('11111111111111111111111111111111'), 10485760, 'application/pdf,image/png,image/jpeg,text/plain' FROM dual
 WHERE NOT EXISTS (SELECT 1 FROM evidence_policy WHERE tenant_id = HEXTORAW('11111111111111111111111111111111'));

-- Preuve de démonstration (D37) sur CST-2026-014-01 (BLOB, sha256 calculé).
INSERT INTO evidence_content (tenant_id, storage_key, sha256, size_bytes, content)
SELECT HEXTORAW('11111111111111111111111111111111'), 'demo/CST-2026-014-01/extrait-virements.txt',
       LOWER(RAWTOHEX(STANDARD_HASH(b, 'SHA256'))), UTL_RAW.LENGTH(b), b
  FROM (SELECT UTL_RAW.CAST_TO_RAW('Extrait de demonstration : 3 virements saisis et valides par U003.') AS b FROM dual)
 WHERE NOT EXISTS (SELECT 1 FROM evidence_content WHERE storage_key = 'demo/CST-2026-014-01/extrait-virements.txt');

INSERT INTO finding_evidence (id, tenant_id, finding_id, file_name, content_type, size_bytes, storage_key, uploaded_by)
SELECT HEXTORAW('e1110000000000000000000000000001'), HEXTORAW('11111111111111111111111111111111'), HEXTORAW('a1110000000000000000000000000001'),
       'extrait-virements.txt', 'text/plain', size_bytes, storage_key, HEXTORAW('22222222222222222222222222222222')
  FROM evidence_content WHERE storage_key = 'demo/CST-2026-014-01/extrait-virements.txt'
   AND NOT EXISTS (SELECT 1 FROM finding_evidence WHERE id = HEXTORAW('e1110000000000000000000000000001'));

COMMIT;

INSERT INTO ccm_run (id, tenant_id, control_code, status, trigger_type, started_at, finished_at, population_size, exceptions_count, data_source, parameters_used)
SELECT HEXTORAW('cc110000000000000000000000000001'), HEXTORAW('11111111111111111111111111111111'), 'COMPTES-DORMANTS', 'SUCCEEDED', 'MANUAL', SYSTIMESTAMP - INTERVAL '1' HOUR, SYSTIMESTAMP - INTERVAL '59' MINUTE, 3, 1, 'amplitude (JDBC, vues V_AUDIT_*)', '{"dormancyMonths":12,"minAmount":"10000","largeOutflowAmount":"100000"}' FROM dual
 WHERE NOT EXISTS (SELECT 1 FROM ccm_run WHERE id = HEXTORAW('cc110000000000000000000000000001'));

-- Jeu de démonstration (D37, §8.7) — équivalent Oracle de seed/demo/demo_tenant_iam.sql, PASSE PLATFORM.
-- À exécuter sous l'utilisateur PLATFORM, AVANT oracle_entity.sql (la passe entité référence platform.tenant).
-- Rejouable : chaque INSERT est gardé par NOT EXISTS sur la clé primaire. UUID → HEXTORAW(...).

INSERT INTO platform.tenant (id, code, label, active)
SELECT HEXTORAW('11111111111111111111111111111111'), 'BANQUE-DEMO', 'Banque Démo', 1 FROM dual
 WHERE NOT EXISTS (SELECT 1 FROM platform.tenant WHERE id = HEXTORAW('11111111111111111111111111111111'));

INSERT INTO platform.tenant_module (tenant_id, module, enabled)
SELECT HEXTORAW('11111111111111111111111111111111'), 'MISSION', 1 FROM dual
 WHERE NOT EXISTS (SELECT 1 FROM platform.tenant_module WHERE tenant_id = HEXTORAW('11111111111111111111111111111111') AND module = 'MISSION');

INSERT INTO platform.tenant_module (tenant_id, module, enabled)
SELECT HEXTORAW('11111111111111111111111111111111'), 'FINDING', 1 FROM dual
 WHERE NOT EXISTS (SELECT 1 FROM platform.tenant_module WHERE tenant_id = HEXTORAW('11111111111111111111111111111111') AND module = 'FINDING');

INSERT INTO platform.tenant_module (tenant_id, module, enabled)
SELECT HEXTORAW('11111111111111111111111111111111'), 'ADMIN', 1 FROM dual
 WHERE NOT EXISTS (SELECT 1 FROM platform.tenant_module WHERE tenant_id = HEXTORAW('11111111111111111111111111111111') AND module = 'ADMIN');

INSERT INTO platform.tenant_module (tenant_id, module, enabled)
SELECT HEXTORAW('11111111111111111111111111111111'), 'OPS', 1 FROM dual
 WHERE NOT EXISTS (SELECT 1 FROM platform.tenant_module WHERE tenant_id = HEXTORAW('11111111111111111111111111111111') AND module = 'OPS');

INSERT INTO platform.user_account (id, tenant_id, username, source, status, mfa_configured, last_login)
SELECT HEXTORAW('22222222222222222222222222222222'), HEXTORAW('11111111111111111111111111111111'), 'ig.demo', 'LOCAL', 'ACTIVE', 1, SYSTIMESTAMP FROM dual
 WHERE NOT EXISTS (SELECT 1 FROM platform.user_account WHERE id = HEXTORAW('22222222222222222222222222222222'));

INSERT INTO platform.user_account (id, tenant_id, username, source, status, mfa_configured, last_login)
SELECT HEXTORAW('22222222222222222222222222222223'), HEXTORAW('11111111111111111111111111111111'), 'insp1.demo', 'AD', 'ACTIVE', 0, SYSTIMESTAMP - INTERVAL '2' DAY FROM dual
 WHERE NOT EXISTS (SELECT 1 FROM platform.user_account WHERE id = HEXTORAW('22222222222222222222222222222223'));

INSERT INTO platform.user_account (id, tenant_id, username, source, status, mfa_configured, last_login)
SELECT HEXTORAW('22222222222222222222222222222224'), HEXTORAW('11111111111111111111111111111111'), 'locked.demo', 'AD', 'LOCKED', 0, NULL FROM dual
 WHERE NOT EXISTS (SELECT 1 FROM platform.user_account WHERE id = HEXTORAW('22222222222222222222222222222224'));

INSERT INTO platform.user_account (id, tenant_id, username, source, status, mfa_configured, last_login)
SELECT HEXTORAW('22222222222222222222222222222225'), HEXTORAW('11111111111111111111111111111111'), 'disabled.demo', 'LOCAL', 'DISABLED', 0, NULL FROM dual
 WHERE NOT EXISTS (SELECT 1 FROM platform.user_account WHERE id = HEXTORAW('22222222222222222222222222222225'));

INSERT INTO platform.user_account (id, tenant_id, username, source, status, mfa_configured, last_login)
SELECT HEXTORAW('22222222222222222222222222222226'), HEXTORAW('11111111111111111111111111111111'), 'noassign.demo', 'AD', 'NO_ASSIGNMENT', 1, NULL FROM dual
 WHERE NOT EXISTS (SELECT 1 FROM platform.user_account WHERE id = HEXTORAW('22222222222222222222222222222226'));

INSERT INTO platform.user_account (id, tenant_id, username, source, status, mfa_configured, last_login)
SELECT HEXTORAW('33333333333333333333333333333333'), HEXTORAW('11111111111111111111111111111111'), 'dsi.admin', 'LOCAL', 'ACTIVE', 1, SYSTIMESTAMP FROM dual
 WHERE NOT EXISTS (SELECT 1 FROM platform.user_account WHERE id = HEXTORAW('33333333333333333333333333333333'));

INSERT INTO platform.directory_sync_state (id, tenant_id, source_code, last_sync_at, status, last_error, version)
SELECT HEXTORAW('33333333333333333333333333333331'), HEXTORAW('11111111111111111111111111111111'), 'AD', SYSTIMESTAMP - INTERVAL '1' HOUR, 'SUCCESS', NULL, 0 FROM dual
 WHERE NOT EXISTS (SELECT 1 FROM platform.directory_sync_state WHERE id = HEXTORAW('33333333333333333333333333333331'));

INSERT INTO platform.directory_sync_state (id, tenant_id, source_code, last_sync_at, status, last_error, version)
SELECT HEXTORAW('33333333333333333333333333333332'), HEXTORAW('11111111111111111111111111111111'), 'AD_BRANCHES', NULL, 'NEVER', NULL, 0 FROM dual
 WHERE NOT EXISTS (SELECT 1 FROM platform.directory_sync_state WHERE id = HEXTORAW('33333333333333333333333333333332'));

COMMIT;

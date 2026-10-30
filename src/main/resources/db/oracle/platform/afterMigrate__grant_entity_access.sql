-- Accès cross-schema de l'entité au schéma partagé PLATFORM (ADR 0012, D39, plan §4.3.5).
-- Callback Flyway de la passe platform, rejoué après chaque migrate (GRANT idempotent) : couvre les
-- tables ajoutées depuis et chaque nouvelle entité. Table par table — aucun privilège ANY.
-- SELECT : lecture par le backend ; REFERENCES : clés étrangères entité → platform.feature.
-- UPDATE ciblé sur TENANT (status/version) et USER_ACCOUNT (actions de compte, D40) et DIRECTORY_SYNC_STATE (état de synchronisation) uniquement.
-- Amendement ADR 0012 (2026-10-29) : l'entité n'a AUCUN DML sur ALERT_RULE* (révoqué ci-dessous) ; ces
-- tables sont écrites par le compte plateforme sans DDL ${platformAppUser} (DataSource plateforme),
-- qui reçoit SELECT/INSERT/UPDATE/DELETE table par table. Placeholder vide = pas de compte applicatif.
-- ${entityUser} : compte de l'entité, fourni par le migrateur (validé comme identifiant Oracle).

BEGIN
  FOR t IN (SELECT table_name FROM user_tables WHERE table_name <> 'flyway_schema_history') LOOP
    EXECUTE IMMEDIATE 'GRANT SELECT, REFERENCES ON "' || t.table_name || '" TO ${entityUser}';
  END LOOP;
  EXECUTE IMMEDIATE 'GRANT UPDATE ON "TENANT" TO ${entityUser}';
  EXECUTE IMMEDIATE 'GRANT UPDATE ON "USER_ACCOUNT" TO ${entityUser}';
  EXECUTE IMMEDIATE 'GRANT INSERT, UPDATE ON "DIRECTORY_SYNC_STATE" TO ${entityUser}';
  -- Révocation idempotente (bases créées avant l'amendement) ; tolère l'absence de table/privilège.
  FOR t IN (SELECT table_name FROM user_tables WHERE table_name IN ('ALERT_RULE', 'ALERT_RULE_CHANNEL')) LOOP
    BEGIN
      EXECUTE IMMEDIATE 'REVOKE INSERT, UPDATE, DELETE ON "' || t.table_name || '" FROM ${entityUser}';
    EXCEPTION WHEN OTHERS THEN
      IF SQLCODE NOT IN (-1927, -942) THEN RAISE; END IF;
    END;
  END LOOP;
  IF '${platformAppUser}' IS NOT NULL THEN
    -- ADR 0012 §Décision 5 : SELECT sur toutes les tables platform ; DML ciblé sur les tables écrites à l'exécution.
    FOR t IN (SELECT table_name FROM user_tables WHERE table_name <> 'flyway_schema_history') LOOP
      EXECUTE IMMEDIATE 'GRANT SELECT ON "' || t.table_name || '" TO ${platformAppUser}';
    END LOOP;
    EXECUTE IMMEDIATE 'GRANT UPDATE ON "TENANT" TO ${platformAppUser}';
    EXECUTE IMMEDIATE 'GRANT UPDATE ON "USER_ACCOUNT" TO ${platformAppUser}';
    EXECUTE IMMEDIATE 'GRANT INSERT, UPDATE ON "DIRECTORY_SYNC_STATE" TO ${platformAppUser}';
    FOR t IN (SELECT table_name FROM user_tables WHERE table_name IN ('ALERT_RULE', 'ALERT_RULE_CHANNEL')) LOOP
      EXECUTE IMMEDIATE 'GRANT SELECT, INSERT, UPDATE, DELETE ON "' || t.table_name || '" TO ${platformAppUser}';
    END LOOP;
  END IF;
END;
/

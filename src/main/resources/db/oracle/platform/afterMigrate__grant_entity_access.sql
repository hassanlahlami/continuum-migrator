-- Accès cross-schema de l'entité au schéma partagé PLATFORM (ADR 0012, D39, plan §4.3.5).
-- Callback Flyway de la passe platform, rejoué après chaque migrate (GRANT idempotent) : couvre les
-- tables ajoutées depuis et chaque nouvelle entité. Table par table — aucun privilège ANY.
-- Entité : SELECT sur toutes les tables ; REFERENCES uniquement sur FEATURE (clés étrangères entité → platform.feature).
-- UPDATE ciblé sur TENANT (status/version) et USER_ACCOUNT (actions de compte, D40) et DIRECTORY_SYNC_STATE (état de synchronisation) uniquement.
-- Amendement ADR 0012 (2026-10-29) : l'entité n'a AUCUN DML sur ALERT_RULE* (révoqué ci-dessous) ; ces
-- tables sont écrites par le compte plateforme sans DDL ${platformAppUser} (DataSource plateforme),
-- qui reçoit le strict nécessaire (ADR 0012 §Décision 5, moindre privilège) : SELECT uniquement sur les 5 tables qu'il écrit. Placeholder vide = pas de compte applicatif.
-- ${entityUser} : compte de l'entité, fourni par le migrateur (validé comme identifiant Oracle).

BEGIN
  FOR t IN (SELECT table_name FROM user_tables WHERE table_name <> 'flyway_schema_history') LOOP
    EXECUTE IMMEDIATE 'GRANT SELECT ON "' || t.table_name || '" TO ${entityUser}';
  END LOOP;
  EXECUTE IMMEDIATE 'GRANT REFERENCES ON "FEATURE" TO ${entityUser}';
  EXECUTE IMMEDIATE 'GRANT UPDATE ON "TENANT" TO ${entityUser}';
  EXECUTE IMMEDIATE 'GRANT UPDATE ON "USER_ACCOUNT" TO ${entityUser}';
  EXECUTE IMMEDIATE 'GRANT INSERT, UPDATE ON "DIRECTORY_SYNC_STATE" TO ${entityUser}';
  -- Révocations idempotentes (bases créées avant l'amendement) ; tolèrent l'absence de table/privilège.
  FOR t IN (SELECT table_name FROM user_tables WHERE table_name IN ('ALERT_RULE', 'ALERT_RULE_CHANNEL')) LOOP
    BEGIN
      EXECUTE IMMEDIATE 'REVOKE INSERT, UPDATE, DELETE ON "' || t.table_name || '" FROM ${entityUser}';
    EXCEPTION WHEN OTHERS THEN
      IF SQLCODE NOT IN (-1927, -942) THEN RAISE; END IF;
    END;
  END LOOP;
  FOR t IN (SELECT table_name FROM user_tables WHERE table_name NOT IN ('flyway_schema_history', 'FEATURE')) LOOP
    BEGIN
      EXECUTE IMMEDIATE 'REVOKE REFERENCES ON "' || t.table_name || '" FROM ${entityUser}';
    EXCEPTION WHEN OTHERS THEN
      IF SQLCODE NOT IN (-1927, -942) THEN RAISE; END IF;
    END;
  END LOOP;
  IF '${platformAppUser}' IS NOT NULL THEN
    FOR t IN (SELECT table_name FROM user_tables WHERE table_name IN
              ('ALERT_RULE', 'ALERT_RULE_CHANNEL', 'TENANT', 'USER_ACCOUNT', 'DIRECTORY_SYNC_STATE')) LOOP
      EXECUTE IMMEDIATE 'GRANT SELECT ON "' || t.table_name || '" TO ${platformAppUser}';
    END LOOP;
    EXECUTE IMMEDIATE 'GRANT UPDATE ON "TENANT" TO ${platformAppUser}';
    EXECUTE IMMEDIATE 'GRANT UPDATE ON "USER_ACCOUNT" TO ${platformAppUser}';
    EXECUTE IMMEDIATE 'GRANT INSERT, UPDATE ON "DIRECTORY_SYNC_STATE" TO ${platformAppUser}';
    FOR t IN (SELECT table_name FROM user_tables WHERE table_name = 'ALERT_RULE') LOOP
      EXECUTE IMMEDIATE 'GRANT INSERT, UPDATE, DELETE ON "ALERT_RULE" TO ${platformAppUser}';
    END LOOP;
    FOR t IN (SELECT table_name FROM user_tables WHERE table_name = 'ALERT_RULE_CHANNEL') LOOP
      EXECUTE IMMEDIATE 'GRANT INSERT, DELETE ON "ALERT_RULE_CHANNEL" TO ${platformAppUser}';
    END LOOP;
    -- Révocations idempotentes : SELECT hors des 5 tables ; UPDATE sur ALERT_RULE_CHANNEL.
    FOR t IN (SELECT table_name FROM user_tables WHERE table_name NOT IN
              ('flyway_schema_history', 'ALERT_RULE', 'ALERT_RULE_CHANNEL', 'TENANT', 'USER_ACCOUNT', 'DIRECTORY_SYNC_STATE')) LOOP
      BEGIN
        EXECUTE IMMEDIATE 'REVOKE SELECT ON "' || t.table_name || '" FROM ${platformAppUser}';
      EXCEPTION WHEN OTHERS THEN
        IF SQLCODE NOT IN (-1927, -942) THEN RAISE; END IF;
      END;
    END LOOP;
    FOR t IN (SELECT table_name FROM user_tables WHERE table_name = 'ALERT_RULE_CHANNEL') LOOP
      BEGIN
        EXECUTE IMMEDIATE 'REVOKE UPDATE ON "ALERT_RULE_CHANNEL" FROM ${platformAppUser}';
      EXCEPTION WHEN OTHERS THEN
        IF SQLCODE NOT IN (-1927, -942) THEN RAISE; END IF;
      END;
    END LOOP;
  END IF;
END;
/

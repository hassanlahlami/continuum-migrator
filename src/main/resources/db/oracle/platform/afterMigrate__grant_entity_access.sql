-- Accès cross-schema de l'entité au schéma partagé PLATFORM (ADR 0012, D39, plan §4.3.5).
-- Callback Flyway de la passe platform, rejoué après chaque migrate (GRANT idempotent) : couvre les
-- tables ajoutées depuis et chaque nouvelle entité. Table par table — aucun privilège ANY.
-- Entité : SELECT sur toutes les tables ; REFERENCES uniquement sur FEATURE (clés étrangères entité → platform.feature).
-- Aucun DML sur le schéma partagé (grants transitoires TENANT/USER_ACCOUNT/DIRECTORY_SYNC_STATE révoqués : écritures via ${platformAppUser}).
-- Amendement ADR 0012 (2026-10-29) : l'entité n'a AUCUN DML sur ALERT_RULE* (révoqué ci-dessous) ; ces
-- tables sont écrites par le compte plateforme sans DDL ${platformAppUser} (DataSource plateforme),
-- qui reçoit le strict nécessaire (ADR 0012 §Décision 5, moindre privilège) : SELECT uniquement sur les 5 tables qu'il écrit. Placeholder vide = pas de compte applicatif.
-- ${entityUser} : compte de l'entité, fourni par le migrateur (validé comme identifiant Oracle).

BEGIN
  -- D41 : les tables AUTH_* (sessions BFF, compteurs) ne sont pas lisibles par l'entité.
  FOR t IN (SELECT table_name FROM user_tables WHERE table_name <> 'flyway_schema_history' AND table_name NOT LIKE 'AUTH#_%' ESCAPE '#') LOOP
    EXECUTE IMMEDIATE 'GRANT SELECT ON "' || t.table_name || '" TO ${entityUser}';
  END LOOP;
  FOR t IN (SELECT table_name FROM user_tables WHERE table_name LIKE 'AUTH#_%' ESCAPE '#') LOOP
    BEGIN
      EXECUTE IMMEDIATE 'REVOKE SELECT ON "' || t.table_name || '" FROM ${entityUser}';
    EXCEPTION WHEN OTHERS THEN
      IF SQLCODE NOT IN (-1927, -942) THEN RAISE; END IF;
    END;
  END LOOP;
  EXECUTE IMMEDIATE 'GRANT REFERENCES ON "FEATURE" TO ${entityUser}';
  -- Révocations idempotentes (bases créées avant l'amendement ; DML transitoire TENANT/USER_ACCOUNT/
  -- DIRECTORY_SYNC_STATE retiré : écritures désormais via le compte plateforme) ; tolèrent l'absence de table/privilège.
  FOR t IN (SELECT table_name FROM user_tables WHERE table_name IN ('ALERT_RULE', 'ALERT_RULE_CHANNEL', 'TENANT', 'USER_ACCOUNT', 'DIRECTORY_SYNC_STATE')) LOOP
    -- Un REVOKE par privilège : ORA-01927 sur l'un ne doit pas empêcher la révocation des autres.
    FOR p IN (SELECT column_value AS priv FROM TABLE(sys.odcivarchar2list('INSERT', 'UPDATE', 'DELETE'))) LOOP
      BEGIN
        EXECUTE IMMEDIATE 'REVOKE ' || p.priv || ' ON "' || t.table_name || '" FROM ${entityUser}';
      EXCEPTION WHEN OTHERS THEN
        IF SQLCODE NOT IN (-1927, -942) THEN RAISE; END IF;
      END;
    END LOOP;
  END LOOP;
  FOR t IN (SELECT table_name FROM user_tables WHERE table_name NOT IN ('flyway_schema_history', 'FEATURE')) LOOP
    BEGIN
      EXECUTE IMMEDIATE 'REVOKE REFERENCES ON "' || t.table_name || '" FROM ${entityUser}';
    EXCEPTION WHEN OTHERS THEN
      IF SQLCODE NOT IN (-1927, -942) THEN RAISE; END IF;
    END;
  END LOOP;
  IF '${platformAppUser}' IS NOT NULL THEN
    -- Vérification de version du schéma au démarrage (CTN-DB-0003, §4.3.5).
    EXECUTE IMMEDIATE 'GRANT SELECT ON "flyway_schema_history" TO ${platformAppUser}';
    FOR t IN (SELECT table_name FROM user_tables WHERE table_name IN
              ('ALERT_RULE', 'ALERT_RULE_CHANNEL', 'TENANT', 'USER_ACCOUNT', 'DIRECTORY_SYNC_STATE',
               'AUTH_SESSION', 'AUTH_LOGIN_ATTEMPT', 'PARAM_DEFAULT', 'TENANT_PARAM')) LOOP
      EXECUTE IMMEDIATE 'GRANT SELECT ON "' || t.table_name || '" TO ${platformAppUser}';
    END LOOP;
    -- D41 (BFF, moindre privilège, ADR 0012) : AUTH_SESSION S/I/U ; AUTH_LOGIN_ATTEMPT S/I/U/D ;
    -- PARAM_DEFAULT et TENANT_PARAM en lecture seule.
    FOR t IN (SELECT table_name FROM user_tables WHERE table_name = 'AUTH_SESSION') LOOP
      EXECUTE IMMEDIATE 'GRANT INSERT, UPDATE ON "AUTH_SESSION" TO ${platformAppUser}';
      BEGIN
        EXECUTE IMMEDIATE 'REVOKE DELETE ON "AUTH_SESSION" FROM ${platformAppUser}';
      EXCEPTION WHEN OTHERS THEN
        IF SQLCODE NOT IN (-1927, -942) THEN RAISE; END IF;
      END;
    END LOOP;
    FOR t IN (SELECT table_name FROM user_tables WHERE table_name = 'AUTH_LOGIN_ATTEMPT') LOOP
      EXECUTE IMMEDIATE 'GRANT INSERT, UPDATE, DELETE ON "AUTH_LOGIN_ATTEMPT" TO ${platformAppUser}';
    END LOOP;
    FOR t IN (SELECT table_name FROM user_tables WHERE table_name = 'TENANT_PARAM') LOOP
      FOR p IN (SELECT column_value AS priv FROM TABLE(sys.odcivarchar2list('INSERT', 'UPDATE', 'DELETE'))) LOOP
        BEGIN
          EXECUTE IMMEDIATE 'REVOKE ' || p.priv || ' ON "TENANT_PARAM" FROM ${platformAppUser}';
        EXCEPTION WHEN OTHERS THEN
          IF SQLCODE NOT IN (-1927, -942) THEN RAISE; END IF;
        END;
      END LOOP;
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
              ('flyway_schema_history', 'ALERT_RULE', 'ALERT_RULE_CHANNEL', 'TENANT', 'USER_ACCOUNT', 'DIRECTORY_SYNC_STATE',
               'AUTH_SESSION', 'AUTH_LOGIN_ATTEMPT', 'PARAM_DEFAULT', 'TENANT_PARAM')) LOOP
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

-- Accès cross-schema de l'entité au schéma partagé PLATFORM (ADR 0012, D39, plan §4.3.5).
-- Callback Flyway de la passe platform, rejoué après chaque migrate (GRANT idempotent) : couvre les
-- tables ajoutées depuis et chaque nouvelle entité. Table par table — aucun privilège ANY.
-- SELECT : lecture par le backend ; REFERENCES : clés étrangères entité → platform.feature.
-- UPDATE ciblé sur TENANT (status/version) et USER_ACCOUNT (actions de compte, D40) et DIRECTORY_SYNC_STATE (état de synchronisation) uniquement.
-- ${entityUser} : compte de l'entité, fourni par le migrateur (validé comme identifiant Oracle).

BEGIN
  FOR t IN (SELECT table_name FROM user_tables WHERE table_name <> 'flyway_schema_history') LOOP
    EXECUTE IMMEDIATE 'GRANT SELECT, REFERENCES ON "' || t.table_name || '" TO ${entityUser}';
  END LOOP;
  EXECUTE IMMEDIATE 'GRANT UPDATE ON "TENANT" TO ${entityUser}';
  EXECUTE IMMEDIATE 'GRANT UPDATE ON "USER_ACCOUNT" TO ${entityUser}';
  EXECUTE IMMEDIATE 'GRANT INSERT, UPDATE ON "DIRECTORY_SYNC_STATE" TO ${entityUser}';
END;
/

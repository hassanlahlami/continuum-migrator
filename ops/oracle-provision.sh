#!/bin/bash
# DBA provisioning for the Oracle two-pass migration (ADR 0012, D39): schema owners only, no ANY privilege.
# Run once as SYSDBA (sim: copy into infra/simulation/oracle/init/). Idempotent.
# Env: PLATFORM_PASSWORD, ENTITY_USER (default CONTINUUM), ENTITY_PASSWORD, PLATFORM_APP_USER (default PLATFORM_APP), PLATFORM_APP_PASSWORD, PDB (default FREEPDB1).
set -euo pipefail
PDB="${PDB:-FREEPDB1}"; ENTITY_USER="${ENTITY_USER:-CONTINUUM}"; PLATFORM_APP_USER="${PLATFORM_APP_USER:-PLATFORM_APP}"

sqlplus -s / as sysdba <<EOSQL
WHENEVER SQLERROR EXIT SQL.SQLCODE
ALTER SESSION SET CONTAINER = ${PDB};
DECLARE
  PROCEDURE ensure_user(u VARCHAR2, p VARCHAR2) IS n NUMBER;
  BEGIN
    SELECT count(*) INTO n FROM dba_users WHERE username = upper(u);
    IF n = 0 THEN EXECUTE IMMEDIATE 'CREATE USER ' || u || ' IDENTIFIED BY "' || p || '" QUOTA UNLIMITED ON USERS';
    ELSE EXECUTE IMMEDIATE 'ALTER USER ' || u || ' IDENTIFIED BY "' || p || '" QUOTA UNLIMITED ON USERS'; END IF;
    EXECUTE IMMEDIATE 'GRANT CREATE SESSION, CREATE TABLE, CREATE SEQUENCE, CREATE VIEW TO ' || u;
  END;
  PROCEDURE ensure_app_user(u VARCHAR2, p VARCHAR2) IS n NUMBER;
  BEGIN
    -- compte applicatif plateforme sans DDL : CREATE SESSION seul, DML accordé par la passe platform
    SELECT count(*) INTO n FROM dba_users WHERE username = upper(u);
    IF n = 0 THEN EXECUTE IMMEDIATE 'CREATE USER ' || u || ' IDENTIFIED BY "' || p || '"';
    ELSE EXECUTE IMMEDIATE 'ALTER USER ' || u || ' IDENTIFIED BY "' || p || '"'; END IF;
    EXECUTE IMMEDIATE 'GRANT CREATE SESSION TO ' || u;
  END;
BEGIN
  ensure_app_user('${PLATFORM_APP_USER}', '${PLATFORM_APP_PASSWORD}');
  ensure_user('PLATFORM', '${PLATFORM_PASSWORD}');
  ensure_user('${ENTITY_USER}', '${ENTITY_PASSWORD}');
END;
/
EOSQL

-- Cycle de vie de l'entité (status) et verrou optimiste (version) sur platform.tenant — dialecte Oracle.
ALTER TABLE platform.tenant ADD (status VARCHAR2(20) DEFAULT 'ACTIVE' NOT NULL);
ALTER TABLE platform.tenant ADD CONSTRAINT ck_tenant_status CHECK (status IN ('PROVISIONING', 'ACTIVE', 'SUSPENDED', 'MAINTENANCE'));
ALTER TABLE platform.tenant ADD (version NUMBER(19) DEFAULT 0 NOT NULL);

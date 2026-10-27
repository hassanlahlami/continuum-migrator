-- Cycle de vie de l'entité (status) et verrou optimiste (version) sur platform.tenant — dialecte PostgreSQL.
-- Les valeurs admises sont celles du contrat (EntityStatus) ; active est conservé pour compatibilité.
ALTER TABLE platform.tenant ADD COLUMN status VARCHAR(20) NOT NULL DEFAULT 'ACTIVE';
ALTER TABLE platform.tenant ADD CONSTRAINT ck_tenant_status CHECK (status IN ('PROVISIONING', 'ACTIVE', 'SUSPENDED', 'MAINTENANCE'));
ALTER TABLE platform.tenant ADD COLUMN version BIGINT NOT NULL DEFAULT 0;

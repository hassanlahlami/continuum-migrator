-- Journal d'audit immuable (plan §2.3) — schéma d'entité, dialecte Oracle.
-- UUID → RAW(16) ; payload → CLOB ; horodatage → TIMESTAMP WITH TIME ZONE.

CREATE TABLE audit_event (
    id            RAW(16) PRIMARY KEY,
    tenant_id     RAW(16) NOT NULL,
    seq           NUMBER(19) NOT NULL,
    occurred_at   TIMESTAMP WITH TIME ZONE NOT NULL,
    actor_user_id RAW(16),
    action        VARCHAR2(150) NOT NULL,
    object_type   VARCHAR2(100),
    object_id     VARCHAR2(100),
    payload       CLOB,
    prev_hash     CHAR(64),
    entry_hash    CHAR(64) NOT NULL,
    CONSTRAINT uq_audit_event_seq UNIQUE (tenant_id, seq)
);

CREATE INDEX idx_audit_event_object ON audit_event (tenant_id, object_type, object_id);

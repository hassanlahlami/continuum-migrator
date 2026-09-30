-- Journal d'audit immuable (plan §2.3) — schéma d'entité, dialecte PostgreSQL.
-- Chaînage + signature HMAC : chaque entrée porte le hachage de la précédente (prev_hash) et son
-- propre entry_hash = HMAC(clé, champs || prev_hash), ce qui rend toute altération détectable.

CREATE TABLE audit_event (
    id            UUID PRIMARY KEY,
    tenant_id     UUID NOT NULL,
    seq           BIGINT NOT NULL,                 -- numéro d'ordre par tenant (chaîne)
    occurred_at   TIMESTAMPTZ NOT NULL,
    actor_user_id UUID,
    action        VARCHAR(150) NOT NULL,           -- code d'action / de fonctionnalité
    object_type   VARCHAR(100),
    object_id     VARCHAR(100),
    payload       TEXT,                            -- avant/après en JSON (stocké verbatim pour l'intégrité)
    prev_hash     CHAR(64),                        -- entry_hash de l'entrée précédente (NULL pour la 1re)
    entry_hash    CHAR(64) NOT NULL,               -- HMAC-SHA256 hex
    UNIQUE (tenant_id, seq)
);

CREATE INDEX idx_audit_event_object ON audit_event (tenant_id, object_type, object_id);

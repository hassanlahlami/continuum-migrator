-- Règles d'alerte d'exploitation (contrat AlertRule, admin/operations.yaml) — périmètre plateforme, sans tenant — dialecte PostgreSQL.
-- window_iso = durée ISO-8601 (ex. PT10M) ; threshold = nombre d'occurrences de event_code dans la fenêtre.
-- Canaux : table enfant alert_rule_channel (IN_APP, EMAIL, SIEM), une ligne par canal activé.
CREATE TABLE platform.alert_rule (
    id              UUID PRIMARY KEY,
    label           VARCHAR(200) NOT NULL,
    event_code      VARCHAR(100) NOT NULL,
    threshold       INTEGER NOT NULL,
    window_iso      VARCHAR(30) NOT NULL,
    enabled         BOOLEAN NOT NULL DEFAULT TRUE,
    version         BIGINT NOT NULL DEFAULT 0,
    created_at      TIMESTAMP WITH TIME ZONE NOT NULL DEFAULT now(),
    updated_at      TIMESTAMP WITH TIME ZONE NOT NULL DEFAULT now()
);

CREATE TABLE platform.alert_rule_channel (
    alert_rule_id   UUID NOT NULL REFERENCES platform.alert_rule (id) ON DELETE CASCADE,
    channel         VARCHAR(20) NOT NULL,
    CONSTRAINT pk_alert_rule_channel PRIMARY KEY (alert_rule_id, channel),
    CONSTRAINT ck_alert_rule_channel_channel CHECK (channel IN ('IN_APP', 'EMAIL', 'SIEM'))
);

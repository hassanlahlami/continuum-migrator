-- Règles d'alerte d'exploitation (contrat AlertRule, admin/operations.yaml) — périmètre plateforme, sans tenant — dialecte Oracle : UUID → RAW(16) ; BOOLEAN → NUMBER(1).
-- window_iso = durée ISO-8601 (ex. PT10M) ; threshold = nombre d'occurrences de event_code dans la fenêtre.
-- Canaux : table enfant ALERT_RULE_CHANNEL (IN_APP, EMAIL, SIEM), une ligne par canal activé.
CREATE TABLE platform.alert_rule (
    id              RAW(16) PRIMARY KEY,
    label           VARCHAR2(200) NOT NULL,
    event_code      VARCHAR2(100) NOT NULL,
    threshold       NUMBER(10) NOT NULL,
    window_iso      VARCHAR2(30) NOT NULL,
    enabled         NUMBER(1) DEFAULT 1 NOT NULL CHECK (enabled IN (0, 1)),
    version         NUMBER(19) DEFAULT 0 NOT NULL,
    created_at      TIMESTAMP WITH TIME ZONE DEFAULT SYSTIMESTAMP NOT NULL,
    updated_at      TIMESTAMP WITH TIME ZONE DEFAULT SYSTIMESTAMP NOT NULL
);

CREATE TABLE platform.alert_rule_channel (
    alert_rule_id   RAW(16) NOT NULL REFERENCES platform.alert_rule (id) ON DELETE CASCADE,
    channel         VARCHAR2(20) NOT NULL,
    CONSTRAINT pk_alert_rule_channel PRIMARY KEY (alert_rule_id, channel),
    CONSTRAINT ck_alert_rule_channel_channel CHECK (channel IN ('IN_APP', 'EMAIL', 'SIEM'))
);

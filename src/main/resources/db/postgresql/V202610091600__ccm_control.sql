-- Paramétrage des contrôles CCM (plan §5, CCM-03) — dialecte PostgreSQL.
-- Les seuils, fréquences et périmètres sont des DONNÉES du tenant (valeurs par défaut livrées par le
-- pack, modifiables par écran), jamais codés en dur (§garde-fous). Un contrôle = une ligne par tenant.
-- `params` (JSON) porte les paramètres propres au contrôle (seuils, listes, codes) ; le moteur ne
-- contient que la règle.

CREATE TABLE ccm_control (
    tenant_id    UUID         NOT NULL,
    control_code VARCHAR(50)  NOT NULL,   -- ex. SEUIL-HORAIRE, COMPTES-DORMANTS, SOD-VIREMENTS
    enabled      BOOLEAN      NOT NULL DEFAULT true,
    params       JSONB        NOT NULL DEFAULT '{}'::jsonb,
    updated_at   TIMESTAMPTZ  NOT NULL DEFAULT now(),
    PRIMARY KEY (tenant_id, control_code)
);

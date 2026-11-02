-- Session serveur du BFF d'authentification (D41, ADR 0014) — périmètre plateforme — dialecte PostgreSQL.
-- id_hash = SHA-256 hexadécimal (64 car.) de l'identifiant de session du cookie : l'id en clair n'est jamais stocké.
-- refresh_token_enc = jeton de rafraîchissement Keycloak chiffré par le backend (la clé n'est jamais en base).
-- Révocable : revoked_at renseigné = session invalide. expires_at = borne absolue ; idle_expires_at = inactivité.
CREATE TABLE platform.auth_session (
    id_hash            VARCHAR(64) PRIMARY KEY,
    tenant_id          UUID NOT NULL REFERENCES platform.tenant (id),
    user_id            UUID NOT NULL,
    refresh_token_enc  BYTEA NOT NULL,
    acr                VARCHAR(50),
    created_at         TIMESTAMP WITH TIME ZONE NOT NULL DEFAULT now(),
    expires_at         TIMESTAMP WITH TIME ZONE NOT NULL,
    idle_expires_at    TIMESTAMP WITH TIME ZONE NOT NULL,
    revoked_at         TIMESTAMP WITH TIME ZONE
);
CREATE INDEX ix_auth_session_user ON platform.auth_session (tenant_id, user_id);
CREATE INDEX ix_auth_session_expires ON platform.auth_session (expires_at);

-- Compteurs de tentatives de connexion (rate-limit) : une ligne par (type de clé, clé).
-- scope_type = IDENTIFIER (clé = hash de tenant+identifiant) ou IP (clé = hash de l'adresse) ; seuils en paramétrage (param_default / tenant_param).
CREATE TABLE platform.auth_login_attempt (
    scope_type     VARCHAR(12) NOT NULL,
    scope_key      VARCHAR(64) NOT NULL,
    tenant_id      UUID REFERENCES platform.tenant (id),
    attempt_count  INTEGER NOT NULL DEFAULT 0,
    window_start   TIMESTAMP WITH TIME ZONE NOT NULL,
    blocked_until  TIMESTAMP WITH TIME ZONE,
    CONSTRAINT pk_auth_login_attempt PRIMARY KEY (scope_type, scope_key),
    CONSTRAINT ck_auth_login_attempt_scope CHECK (scope_type IN ('IDENTIFIER', 'IP'))
);

-- Paramétrage : valeur par défaut de l'installation (livrée par le pack) + surcharge par tenant.
-- Valeur effective = tenant_param sinon param_default. Valeurs en texte ; typage par clé (voir description).
CREATE TABLE platform.param_default (
    param_key    VARCHAR(100) PRIMARY KEY,
    param_value  VARCHAR(1000) NOT NULL,
    description  VARCHAR(500)
);
CREATE TABLE platform.tenant_param (
    tenant_id    UUID NOT NULL REFERENCES platform.tenant (id) ON DELETE CASCADE,
    param_key    VARCHAR(100) NOT NULL REFERENCES platform.param_default (param_key),
    param_value  VARCHAR(1000) NOT NULL,
    CONSTRAINT pk_tenant_param PRIMARY KEY (tenant_id, param_key)
);

-- Défauts du pack — les valeurs numériques sont toutes ⟨à valider⟩ (aucun chiffre sourcé).
INSERT INTO platform.param_default (param_key, param_value, description) VALUES
 ('auth.login.mode', 'redirect', 'rest | redirect — voie de connexion (ADR 0014) ; redirect par défaut, rest jamais pour admin/signatures'),
 ('auth.session.idle_timeout_seconds', '1800', 'Inactivité avant expiration de session — ⟨à valider⟩'),
 ('auth.session.absolute_timeout_seconds', '28800', 'Durée maximale de session — ⟨à valider⟩'),
 ('auth.ratelimit.identifier.max_attempts', '5', 'Échecs max par (tenant, identifiant) dans la fenêtre — ⟨à valider⟩'),
 ('auth.ratelimit.identifier.window_seconds', '900', 'Fenêtre de comptage par identifiant — ⟨à valider⟩'),
 ('auth.ratelimit.ip.max_attempts', '20', 'Échecs max par IP dans la fenêtre — ⟨à valider⟩'),
 ('auth.ratelimit.ip.window_seconds', '900', 'Fenêtre de comptage par IP — ⟨à valider⟩'),
 ('auth.ratelimit.block_seconds', '900', 'Durée de blocage (Retry-After) après dépassement — ⟨à valider⟩');

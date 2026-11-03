-- Front propriétaire de la session BFF (ADR 0014 addendum b) : 'app' (application fonctionnelle) ou 'admin' (console d'administration).
ALTER TABLE platform.auth_session ADD COLUMN app VARCHAR(10) NOT NULL DEFAULT 'app';

-- Front propriétaire de la session BFF (ADR 0014 addendum b) : 'app' (application fonctionnelle) ou 'admin' (console d'administration).
ALTER TABLE platform.auth_session ADD (app VARCHAR2(10) DEFAULT 'app' NOT NULL);

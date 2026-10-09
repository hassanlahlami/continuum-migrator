-- Thème du tenant (plan §1.6) — dialecte PostgreSQL. L'apparence est une DONNÉE du tenant,
-- appliquée à l'exécution : jeu de tokens --ct-* (JSON { "--ct-...": "valeur" }) servi en CSS par
-- GET /api/public/theme. version alimente l'ETag (mise en cache navigateur).

CREATE TABLE tenant_theme (
    tenant_id  UUID PRIMARY KEY,
    tokens     JSONB NOT NULL,
    version    INTEGER NOT NULL DEFAULT 1,
    updated_at TIMESTAMPTZ NOT NULL DEFAULT now()
);

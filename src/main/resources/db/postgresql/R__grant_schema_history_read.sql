-- Lecture de la table d'historique Flyway par le compte applicatif (plan §4.3.5, CTN-DB-0003) :
-- le backend vérifie la version du schéma au démarrage. Rejouable ; sans effet si le rôle n'existe pas.
DO $$
BEGIN
  IF EXISTS (SELECT 1 FROM pg_roles WHERE rolname = 'continuum_app') THEN
    EXECUTE 'GRANT SELECT ON flyway_schema_history TO continuum_app';
  END IF;
END
$$;

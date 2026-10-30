-- Compte applicatif PostgreSQL non-superuser (LOGIN, ni CREATEROLE ni CREATEDB) : DML sur les schémas
-- public et platform, rejoué après chaque migrate (couvre les tables ajoutées depuis). Aucun DDL.
-- Sans effet si le rôle continuum_app n'existe pas.
DO $$
DECLARE s text;
BEGIN
  IF EXISTS (SELECT 1 FROM pg_roles WHERE rolname = 'continuum_app') THEN
    FOREACH s IN ARRAY ARRAY['public', 'platform'] LOOP
      IF EXISTS (SELECT 1 FROM pg_namespace WHERE nspname = s) THEN
        EXECUTE format('GRANT USAGE ON SCHEMA %I TO continuum_app', s);
        EXECUTE format('GRANT SELECT, INSERT, UPDATE, DELETE ON ALL TABLES IN SCHEMA %I TO continuum_app', s);
        EXECUTE format('GRANT USAGE, SELECT ON ALL SEQUENCES IN SCHEMA %I TO continuum_app', s);
      END IF;
    END LOOP;
  END IF;
END
$$;

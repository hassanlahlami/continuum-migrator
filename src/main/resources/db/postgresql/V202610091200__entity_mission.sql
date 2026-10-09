-- Entité Mission (plan §6, contrat app/missions.yaml) — dialecte PostgreSQL.
-- Les libellés de référentiels (type, statut, phase) sont conservés inline pour la lecture ; leur
-- résolution via référentiel paramétrable par tenant (§1.6) viendra avec le module de paramétrage.

CREATE TABLE mission (
    id                 UUID PRIMARY KEY,
    tenant_id          UUID NOT NULL,
    org_unit_id        UUID REFERENCES org_unit(id),
    reference          VARCHAR(50)  NOT NULL,
    title              VARCHAR(300) NOT NULL,
    mission_type_code  VARCHAR(50)  NOT NULL,
    mission_type_label VARCHAR(200) NOT NULL,
    status_code        VARCHAR(50)  NOT NULL,
    status_label       VARCHAR(200) NOT NULL,
    phase_code         VARCHAR(50)  NOT NULL,
    phase_label        VARCHAR(200) NOT NULL,
    progress_percent   INTEGER,
    planned_start      DATE,
    planned_end        DATE,
    created_at         TIMESTAMPTZ NOT NULL DEFAULT now(),
    version            INTEGER NOT NULL DEFAULT 0,
    UNIQUE (tenant_id, reference)
);

CREATE INDEX idx_mission_tenant_unit ON mission (tenant_id, org_unit_id);

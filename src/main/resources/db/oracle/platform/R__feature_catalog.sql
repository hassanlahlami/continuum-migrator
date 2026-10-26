-- GÉNÉRÉ — ne pas éditer à la main.
-- Source : registre Java com.continuum.iam.api.Feature (plan §2.1.7).
-- Régénérer : FeatureCatalogSqlGenerator (§4.3.5). La CI échoue si ce fichier diverge du registre.

MERGE INTO platform.feature t USING (SELECT 'admin.alerts.manage' code, 'ADMIN' module, 'feature.admin.alerts.manage' label_key, 1 scopable, 0 sensitive, 0 deprecated FROM dual) s ON (t.code = s.code)
WHEN MATCHED THEN UPDATE SET t.module = s.module, t.label_key = s.label_key, t.scopable = s.scopable, t.sensitive = s.sensitive, t.deprecated = s.deprecated
WHEN NOT MATCHED THEN INSERT (code, module, label_key, scopable, sensitive, deprecated) VALUES (s.code, s.module, s.label_key, s.scopable, s.sensitive, s.deprecated);
MERGE INTO platform.feature t USING (SELECT 'admin.assignment.manage' code, 'ADMIN' module, 'feature.admin.assignment.manage' label_key, 1 scopable, 1 sensitive, 0 deprecated FROM dual) s ON (t.code = s.code)
WHEN MATCHED THEN UPDATE SET t.module = s.module, t.label_key = s.label_key, t.scopable = s.scopable, t.sensitive = s.sensitive, t.deprecated = s.deprecated
WHEN NOT MATCHED THEN INSERT (code, module, label_key, scopable, sensitive, deprecated) VALUES (s.code, s.module, s.label_key, s.scopable, s.sensitive, s.deprecated);
MERGE INTO platform.feature t USING (SELECT 'admin.assignment.read' code, 'ADMIN' module, 'feature.admin.assignment.read' label_key, 1 scopable, 0 sensitive, 0 deprecated FROM dual) s ON (t.code = s.code)
WHEN MATCHED THEN UPDATE SET t.module = s.module, t.label_key = s.label_key, t.scopable = s.scopable, t.sensitive = s.sensitive, t.deprecated = s.deprecated
WHEN NOT MATCHED THEN INSERT (code, module, label_key, scopable, sensitive, deprecated) VALUES (s.code, s.module, s.label_key, s.scopable, s.sensitive, s.deprecated);
MERGE INTO platform.feature t USING (SELECT 'admin.authz.simulate' code, 'ADMIN' module, 'feature.admin.authz.simulate' label_key, 1 scopable, 0 sensitive, 0 deprecated FROM dual) s ON (t.code = s.code)
WHEN MATCHED THEN UPDATE SET t.module = s.module, t.label_key = s.label_key, t.scopable = s.scopable, t.sensitive = s.sensitive, t.deprecated = s.deprecated
WHEN NOT MATCHED THEN INSERT (code, module, label_key, scopable, sensitive, deprecated) VALUES (s.code, s.module, s.label_key, s.scopable, s.sensitive, s.deprecated);
MERGE INTO platform.feature t USING (SELECT 'admin.cache.evict' code, 'ADMIN' module, 'feature.admin.cache.evict' label_key, 1 scopable, 0 sensitive, 0 deprecated FROM dual) s ON (t.code = s.code)
WHEN MATCHED THEN UPDATE SET t.module = s.module, t.label_key = s.label_key, t.scopable = s.scopable, t.sensitive = s.sensitive, t.deprecated = s.deprecated
WHEN NOT MATCHED THEN INSERT (code, module, label_key, scopable, sensitive, deprecated) VALUES (s.code, s.module, s.label_key, s.scopable, s.sensitive, s.deprecated);
MERGE INTO platform.feature t USING (SELECT 'admin.cache.evict.all' code, 'ADMIN' module, 'feature.admin.cache.evict.all' label_key, 1 scopable, 1 sensitive, 0 deprecated FROM dual) s ON (t.code = s.code)
WHEN MATCHED THEN UPDATE SET t.module = s.module, t.label_key = s.label_key, t.scopable = s.scopable, t.sensitive = s.sensitive, t.deprecated = s.deprecated
WHEN NOT MATCHED THEN INSERT (code, module, label_key, scopable, sensitive, deprecated) VALUES (s.code, s.module, s.label_key, s.scopable, s.sensitive, s.deprecated);
MERGE INTO platform.feature t USING (SELECT 'admin.cache.read' code, 'ADMIN' module, 'feature.admin.cache.read' label_key, 1 scopable, 0 sensitive, 0 deprecated FROM dual) s ON (t.code = s.code)
WHEN MATCHED THEN UPDATE SET t.module = s.module, t.label_key = s.label_key, t.scopable = s.scopable, t.sensitive = s.sensitive, t.deprecated = s.deprecated
WHEN NOT MATCHED THEN INSERT (code, module, label_key, scopable, sensitive, deprecated) VALUES (s.code, s.module, s.label_key, s.scopable, s.sensitive, s.deprecated);
MERGE INTO platform.feature t USING (SELECT 'admin.change.approve' code, 'ADMIN' module, 'feature.admin.change.approve' label_key, 1 scopable, 1 sensitive, 0 deprecated FROM dual) s ON (t.code = s.code)
WHEN MATCHED THEN UPDATE SET t.module = s.module, t.label_key = s.label_key, t.scopable = s.scopable, t.sensitive = s.sensitive, t.deprecated = s.deprecated
WHEN NOT MATCHED THEN INSERT (code, module, label_key, scopable, sensitive, deprecated) VALUES (s.code, s.module, s.label_key, s.scopable, s.sensitive, s.deprecated);
MERGE INTO platform.feature t USING (SELECT 'admin.entity.manage' code, 'ADMIN' module, 'feature.admin.entity.manage' label_key, 1 scopable, 1 sensitive, 0 deprecated FROM dual) s ON (t.code = s.code)
WHEN MATCHED THEN UPDATE SET t.module = s.module, t.label_key = s.label_key, t.scopable = s.scopable, t.sensitive = s.sensitive, t.deprecated = s.deprecated
WHEN NOT MATCHED THEN INSERT (code, module, label_key, scopable, sensitive, deprecated) VALUES (s.code, s.module, s.label_key, s.scopable, s.sensitive, s.deprecated);
MERGE INTO platform.feature t USING (SELECT 'admin.entity.read' code, 'ADMIN' module, 'feature.admin.entity.read' label_key, 1 scopable, 0 sensitive, 0 deprecated FROM dual) s ON (t.code = s.code)
WHEN MATCHED THEN UPDATE SET t.module = s.module, t.label_key = s.label_key, t.scopable = s.scopable, t.sensitive = s.sensitive, t.deprecated = s.deprecated
WHEN NOT MATCHED THEN INSERT (code, module, label_key, scopable, sensitive, deprecated) VALUES (s.code, s.module, s.label_key, s.scopable, s.sensitive, s.deprecated);
MERGE INTO platform.feature t USING (SELECT 'admin.logs.export' code, 'ADMIN' module, 'feature.admin.logs.export' label_key, 1 scopable, 1 sensitive, 0 deprecated FROM dual) s ON (t.code = s.code)
WHEN MATCHED THEN UPDATE SET t.module = s.module, t.label_key = s.label_key, t.scopable = s.scopable, t.sensitive = s.sensitive, t.deprecated = s.deprecated
WHEN NOT MATCHED THEN INSERT (code, module, label_key, scopable, sensitive, deprecated) VALUES (s.code, s.module, s.label_key, s.scopable, s.sensitive, s.deprecated);
MERGE INTO platform.feature t USING (SELECT 'admin.logs.level.change' code, 'ADMIN' module, 'feature.admin.logs.level.change' label_key, 1 scopable, 1 sensitive, 0 deprecated FROM dual) s ON (t.code = s.code)
WHEN MATCHED THEN UPDATE SET t.module = s.module, t.label_key = s.label_key, t.scopable = s.scopable, t.sensitive = s.sensitive, t.deprecated = s.deprecated
WHEN NOT MATCHED THEN INSERT (code, module, label_key, scopable, sensitive, deprecated) VALUES (s.code, s.module, s.label_key, s.scopable, s.sensitive, s.deprecated);
MERGE INTO platform.feature t USING (SELECT 'admin.logs.security.read' code, 'ADMIN' module, 'feature.admin.logs.security.read' label_key, 1 scopable, 1 sensitive, 0 deprecated FROM dual) s ON (t.code = s.code)
WHEN MATCHED THEN UPDATE SET t.module = s.module, t.label_key = s.label_key, t.scopable = s.scopable, t.sensitive = s.sensitive, t.deprecated = s.deprecated
WHEN NOT MATCHED THEN INSERT (code, module, label_key, scopable, sensitive, deprecated) VALUES (s.code, s.module, s.label_key, s.scopable, s.sensitive, s.deprecated);
MERGE INTO platform.feature t USING (SELECT 'admin.logs.tech.read' code, 'ADMIN' module, 'feature.admin.logs.tech.read' label_key, 1 scopable, 0 sensitive, 0 deprecated FROM dual) s ON (t.code = s.code)
WHEN MATCHED THEN UPDATE SET t.module = s.module, t.label_key = s.label_key, t.scopable = s.scopable, t.sensitive = s.sensitive, t.deprecated = s.deprecated
WHEN NOT MATCHED THEN INSERT (code, module, label_key, scopable, sensitive, deprecated) VALUES (s.code, s.module, s.label_key, s.scopable, s.sensitive, s.deprecated);
MERGE INTO platform.feature t USING (SELECT 'admin.org.manage' code, 'ADMIN' module, 'feature.admin.org.manage' label_key, 1 scopable, 1 sensitive, 0 deprecated FROM dual) s ON (t.code = s.code)
WHEN MATCHED THEN UPDATE SET t.module = s.module, t.label_key = s.label_key, t.scopable = s.scopable, t.sensitive = s.sensitive, t.deprecated = s.deprecated
WHEN NOT MATCHED THEN INSERT (code, module, label_key, scopable, sensitive, deprecated) VALUES (s.code, s.module, s.label_key, s.scopable, s.sensitive, s.deprecated);
MERGE INTO platform.feature t USING (SELECT 'admin.org.read' code, 'ADMIN' module, 'feature.admin.org.read' label_key, 1 scopable, 0 sensitive, 0 deprecated FROM dual) s ON (t.code = s.code)
WHEN MATCHED THEN UPDATE SET t.module = s.module, t.label_key = s.label_key, t.scopable = s.scopable, t.sensitive = s.sensitive, t.deprecated = s.deprecated
WHEN NOT MATCHED THEN INSERT (code, module, label_key, scopable, sensitive, deprecated) VALUES (s.code, s.module, s.label_key, s.scopable, s.sensitive, s.deprecated);
MERGE INTO platform.feature t USING (SELECT 'admin.overview.read' code, 'ADMIN' module, 'feature.admin.overview.read' label_key, 1 scopable, 0 sensitive, 0 deprecated FROM dual) s ON (t.code = s.code)
WHEN MATCHED THEN UPDATE SET t.module = s.module, t.label_key = s.label_key, t.scopable = s.scopable, t.sensitive = s.sensitive, t.deprecated = s.deprecated
WHEN NOT MATCHED THEN INSERT (code, module, label_key, scopable, sensitive, deprecated) VALUES (s.code, s.module, s.label_key, s.scopable, s.sensitive, s.deprecated);
MERGE INTO platform.feature t USING (SELECT 'admin.position.manage' code, 'ADMIN' module, 'feature.admin.position.manage' label_key, 1 scopable, 1 sensitive, 0 deprecated FROM dual) s ON (t.code = s.code)
WHEN MATCHED THEN UPDATE SET t.module = s.module, t.label_key = s.label_key, t.scopable = s.scopable, t.sensitive = s.sensitive, t.deprecated = s.deprecated
WHEN NOT MATCHED THEN INSERT (code, module, label_key, scopable, sensitive, deprecated) VALUES (s.code, s.module, s.label_key, s.scopable, s.sensitive, s.deprecated);
MERGE INTO platform.feature t USING (SELECT 'admin.position.read' code, 'ADMIN' module, 'feature.admin.position.read' label_key, 1 scopable, 0 sensitive, 0 deprecated FROM dual) s ON (t.code = s.code)
WHEN MATCHED THEN UPDATE SET t.module = s.module, t.label_key = s.label_key, t.scopable = s.scopable, t.sensitive = s.sensitive, t.deprecated = s.deprecated
WHEN NOT MATCHED THEN INSERT (code, module, label_key, scopable, sensitive, deprecated) VALUES (s.code, s.module, s.label_key, s.scopable, s.sensitive, s.deprecated);
MERGE INTO platform.feature t USING (SELECT 'admin.recertification.manage' code, 'ADMIN' module, 'feature.admin.recertification.manage' label_key, 1 scopable, 1 sensitive, 0 deprecated FROM dual) s ON (t.code = s.code)
WHEN MATCHED THEN UPDATE SET t.module = s.module, t.label_key = s.label_key, t.scopable = s.scopable, t.sensitive = s.sensitive, t.deprecated = s.deprecated
WHEN NOT MATCHED THEN INSERT (code, module, label_key, scopable, sensitive, deprecated) VALUES (s.code, s.module, s.label_key, s.scopable, s.sensitive, s.deprecated);
MERGE INTO platform.feature t USING (SELECT 'admin.role.manage' code, 'ADMIN' module, 'feature.admin.role.manage' label_key, 1 scopable, 1 sensitive, 0 deprecated FROM dual) s ON (t.code = s.code)
WHEN MATCHED THEN UPDATE SET t.module = s.module, t.label_key = s.label_key, t.scopable = s.scopable, t.sensitive = s.sensitive, t.deprecated = s.deprecated
WHEN NOT MATCHED THEN INSERT (code, module, label_key, scopable, sensitive, deprecated) VALUES (s.code, s.module, s.label_key, s.scopable, s.sensitive, s.deprecated);
MERGE INTO platform.feature t USING (SELECT 'admin.role.read' code, 'ADMIN' module, 'feature.admin.role.read' label_key, 1 scopable, 0 sensitive, 0 deprecated FROM dual) s ON (t.code = s.code)
WHEN MATCHED THEN UPDATE SET t.module = s.module, t.label_key = s.label_key, t.scopable = s.scopable, t.sensitive = s.sensitive, t.deprecated = s.deprecated
WHEN NOT MATCHED THEN INSERT (code, module, label_key, scopable, sensitive, deprecated) VALUES (s.code, s.module, s.label_key, s.scopable, s.sensitive, s.deprecated);
MERGE INTO platform.feature t USING (SELECT 'admin.sod.manage' code, 'ADMIN' module, 'feature.admin.sod.manage' label_key, 1 scopable, 1 sensitive, 0 deprecated FROM dual) s ON (t.code = s.code)
WHEN MATCHED THEN UPDATE SET t.module = s.module, t.label_key = s.label_key, t.scopable = s.scopable, t.sensitive = s.sensitive, t.deprecated = s.deprecated
WHEN NOT MATCHED THEN INSERT (code, module, label_key, scopable, sensitive, deprecated) VALUES (s.code, s.module, s.label_key, s.scopable, s.sensitive, s.deprecated);
MERGE INTO platform.feature t USING (SELECT 'admin.sod.read' code, 'ADMIN' module, 'feature.admin.sod.read' label_key, 1 scopable, 0 sensitive, 0 deprecated FROM dual) s ON (t.code = s.code)
WHEN MATCHED THEN UPDATE SET t.module = s.module, t.label_key = s.label_key, t.scopable = s.scopable, t.sensitive = s.sensitive, t.deprecated = s.deprecated
WHEN NOT MATCHED THEN INSERT (code, module, label_key, scopable, sensitive, deprecated) VALUES (s.code, s.module, s.label_key, s.scopable, s.sensitive, s.deprecated);
MERGE INTO platform.feature t USING (SELECT 'admin.user.manage' code, 'ADMIN' module, 'feature.admin.user.manage' label_key, 1 scopable, 1 sensitive, 0 deprecated FROM dual) s ON (t.code = s.code)
WHEN MATCHED THEN UPDATE SET t.module = s.module, t.label_key = s.label_key, t.scopable = s.scopable, t.sensitive = s.sensitive, t.deprecated = s.deprecated
WHEN NOT MATCHED THEN INSERT (code, module, label_key, scopable, sensitive, deprecated) VALUES (s.code, s.module, s.label_key, s.scopable, s.sensitive, s.deprecated);
MERGE INTO platform.feature t USING (SELECT 'admin.user.read' code, 'ADMIN' module, 'feature.admin.user.read' label_key, 1 scopable, 0 sensitive, 0 deprecated FROM dual) s ON (t.code = s.code)
WHEN MATCHED THEN UPDATE SET t.module = s.module, t.label_key = s.label_key, t.scopable = s.scopable, t.sensitive = s.sensitive, t.deprecated = s.deprecated
WHEN NOT MATCHED THEN INSERT (code, module, label_key, scopable, sensitive, deprecated) VALUES (s.code, s.module, s.label_key, s.scopable, s.sensitive, s.deprecated);
MERGE INTO platform.feature t USING (SELECT 'auditee.space' code, 'AUDITEE' module, 'feature.auditee.space' label_key, 1 scopable, 0 sensitive, 0 deprecated FROM dual) s ON (t.code = s.code)
WHEN MATCHED THEN UPDATE SET t.module = s.module, t.label_key = s.label_key, t.scopable = s.scopable, t.sensitive = s.sensitive, t.deprecated = s.deprecated
WHEN NOT MATCHED THEN INSERT (code, module, label_key, scopable, sensitive, deprecated) VALUES (s.code, s.module, s.label_key, s.scopable, s.sensitive, s.deprecated);
MERGE INTO platform.feature t USING (SELECT 'ccm.control.configure' code, 'CCM' module, 'feature.ccm.control.configure' label_key, 1 scopable, 1 sensitive, 0 deprecated FROM dual) s ON (t.code = s.code)
WHEN MATCHED THEN UPDATE SET t.module = s.module, t.label_key = s.label_key, t.scopable = s.scopable, t.sensitive = s.sensitive, t.deprecated = s.deprecated
WHEN NOT MATCHED THEN INSERT (code, module, label_key, scopable, sensitive, deprecated) VALUES (s.code, s.module, s.label_key, s.scopable, s.sensitive, s.deprecated);
MERGE INTO platform.feature t USING (SELECT 'ccm.control.run' code, 'CCM' module, 'feature.ccm.control.run' label_key, 1 scopable, 0 sensitive, 0 deprecated FROM dual) s ON (t.code = s.code)
WHEN MATCHED THEN UPDATE SET t.module = s.module, t.label_key = s.label_key, t.scopable = s.scopable, t.sensitive = s.sensitive, t.deprecated = s.deprecated
WHEN NOT MATCHED THEN INSERT (code, module, label_key, scopable, sensitive, deprecated) VALUES (s.code, s.module, s.label_key, s.scopable, s.sensitive, s.deprecated);
MERGE INTO platform.feature t USING (SELECT 'ccm.exception.convert' code, 'CCM' module, 'feature.ccm.exception.convert' label_key, 1 scopable, 0 sensitive, 0 deprecated FROM dual) s ON (t.code = s.code)
WHEN MATCHED THEN UPDATE SET t.module = s.module, t.label_key = s.label_key, t.scopable = s.scopable, t.sensitive = s.sensitive, t.deprecated = s.deprecated
WHEN NOT MATCHED THEN INSERT (code, module, label_key, scopable, sensitive, deprecated) VALUES (s.code, s.module, s.label_key, s.scopable, s.sensitive, s.deprecated);
MERGE INTO platform.feature t USING (SELECT 'ccm.exception.triage' code, 'CCM' module, 'feature.ccm.exception.triage' label_key, 1 scopable, 0 sensitive, 0 deprecated FROM dual) s ON (t.code = s.code)
WHEN MATCHED THEN UPDATE SET t.module = s.module, t.label_key = s.label_key, t.scopable = s.scopable, t.sensitive = s.sensitive, t.deprecated = s.deprecated
WHEN NOT MATCHED THEN INSERT (code, module, label_key, scopable, sensitive, deprecated) VALUES (s.code, s.module, s.label_key, s.scopable, s.sensitive, s.deprecated);
MERGE INTO platform.feature t USING (SELECT 'ccm.population.explore' code, 'CCM' module, 'feature.ccm.population.explore' label_key, 1 scopable, 0 sensitive, 0 deprecated FROM dual) s ON (t.code = s.code)
WHEN MATCHED THEN UPDATE SET t.module = s.module, t.label_key = s.label_key, t.scopable = s.scopable, t.sensitive = s.sensitive, t.deprecated = s.deprecated
WHEN NOT MATCHED THEN INSERT (code, module, label_key, scopable, sensitive, deprecated) VALUES (s.code, s.module, s.label_key, s.scopable, s.sensitive, s.deprecated);
MERGE INTO platform.feature t USING (SELECT 'ccm.read' code, 'CCM' module, 'feature.ccm.read' label_key, 1 scopable, 0 sensitive, 0 deprecated FROM dual) s ON (t.code = s.code)
WHEN MATCHED THEN UPDATE SET t.module = s.module, t.label_key = s.label_key, t.scopable = s.scopable, t.sensitive = s.sensitive, t.deprecated = s.deprecated
WHEN NOT MATCHED THEN INSERT (code, module, label_key, scopable, sensitive, deprecated) VALUES (s.code, s.module, s.label_key, s.scopable, s.sensitive, s.deprecated);
MERGE INTO platform.feature t USING (SELECT 'ccm.reconciliation.read' code, 'CCM' module, 'feature.ccm.reconciliation.read' label_key, 1 scopable, 0 sensitive, 0 deprecated FROM dual) s ON (t.code = s.code)
WHEN MATCHED THEN UPDATE SET t.module = s.module, t.label_key = s.label_key, t.scopable = s.scopable, t.sensitive = s.sensitive, t.deprecated = s.deprecated
WHEN NOT MATCHED THEN INSERT (code, module, label_key, scopable, sensitive, deprecated) VALUES (s.code, s.module, s.label_key, s.scopable, s.sensitive, s.deprecated);
MERGE INTO platform.feature t USING (SELECT 'charter.approve' code, 'CHARTER' module, 'feature.charter.approve' label_key, 1 scopable, 1 sensitive, 0 deprecated FROM dual) s ON (t.code = s.code)
WHEN MATCHED THEN UPDATE SET t.module = s.module, t.label_key = s.label_key, t.scopable = s.scopable, t.sensitive = s.sensitive, t.deprecated = s.deprecated
WHEN NOT MATCHED THEN INSERT (code, module, label_key, scopable, sensitive, deprecated) VALUES (s.code, s.module, s.label_key, s.scopable, s.sensitive, s.deprecated);
MERGE INTO platform.feature t USING (SELECT 'external.finding.manage' code, 'EXTERNAL' module, 'feature.external.finding.manage' label_key, 1 scopable, 0 sensitive, 0 deprecated FROM dual) s ON (t.code = s.code)
WHEN MATCHED THEN UPDATE SET t.module = s.module, t.label_key = s.label_key, t.scopable = s.scopable, t.sensitive = s.sensitive, t.deprecated = s.deprecated
WHEN NOT MATCHED THEN INSERT (code, module, label_key, scopable, sensitive, deprecated) VALUES (s.code, s.module, s.label_key, s.scopable, s.sensitive, s.deprecated);
MERGE INTO platform.feature t USING (SELECT 'external.finding.read' code, 'EXTERNAL' module, 'feature.external.finding.read' label_key, 1 scopable, 0 sensitive, 0 deprecated FROM dual) s ON (t.code = s.code)
WHEN MATCHED THEN UPDATE SET t.module = s.module, t.label_key = s.label_key, t.scopable = s.scopable, t.sensitive = s.sensitive, t.deprecated = s.deprecated
WHEN NOT MATCHED THEN INSERT (code, module, label_key, scopable, sensitive, deprecated) VALUES (s.code, s.module, s.label_key, s.scopable, s.sensitive, s.deprecated);
MERGE INTO platform.feature t USING (SELECT 'finding.consolidate' code, 'FINDING' module, 'feature.finding.consolidate' label_key, 1 scopable, 0 sensitive, 0 deprecated FROM dual) s ON (t.code = s.code)
WHEN MATCHED THEN UPDATE SET t.module = s.module, t.label_key = s.label_key, t.scopable = s.scopable, t.sensitive = s.sensitive, t.deprecated = s.deprecated
WHEN NOT MATCHED THEN INSERT (code, module, label_key, scopable, sensitive, deprecated) VALUES (s.code, s.module, s.label_key, s.scopable, s.sensitive, s.deprecated);
MERGE INTO platform.feature t USING (SELECT 'finding.read' code, 'FINDING' module, 'feature.finding.read' label_key, 1 scopable, 0 sensitive, 0 deprecated FROM dual) s ON (t.code = s.code)
WHEN MATCHED THEN UPDATE SET t.module = s.module, t.label_key = s.label_key, t.scopable = s.scopable, t.sensitive = s.sensitive, t.deprecated = s.deprecated
WHEN NOT MATCHED THEN INSERT (code, module, label_key, scopable, sensitive, deprecated) VALUES (s.code, s.module, s.label_key, s.scopable, s.sensitive, s.deprecated);
MERGE INTO platform.feature t USING (SELECT 'finding.review' code, 'FINDING' module, 'feature.finding.review' label_key, 1 scopable, 0 sensitive, 0 deprecated FROM dual) s ON (t.code = s.code)
WHEN MATCHED THEN UPDATE SET t.module = s.module, t.label_key = s.label_key, t.scopable = s.scopable, t.sensitive = s.sensitive, t.deprecated = s.deprecated
WHEN NOT MATCHED THEN INSERT (code, module, label_key, scopable, sensitive, deprecated) VALUES (s.code, s.module, s.label_key, s.scopable, s.sensitive, s.deprecated);
MERGE INTO platform.feature t USING (SELECT 'finding.validate' code, 'FINDING' module, 'feature.finding.validate' label_key, 1 scopable, 1 sensitive, 0 deprecated FROM dual) s ON (t.code = s.code)
WHEN MATCHED THEN UPDATE SET t.module = s.module, t.label_key = s.label_key, t.scopable = s.scopable, t.sensitive = s.sensitive, t.deprecated = s.deprecated
WHEN NOT MATCHED THEN INSERT (code, module, label_key, scopable, sensitive, deprecated) VALUES (s.code, s.module, s.label_key, s.scopable, s.sensitive, s.deprecated);
MERGE INTO platform.feature t USING (SELECT 'finding.write' code, 'FINDING' module, 'feature.finding.write' label_key, 1 scopable, 0 sensitive, 0 deprecated FROM dual) s ON (t.code = s.code)
WHEN MATCHED THEN UPDATE SET t.module = s.module, t.label_key = s.label_key, t.scopable = s.scopable, t.sensitive = s.sensitive, t.deprecated = s.deprecated
WHEN NOT MATCHED THEN INSERT (code, module, label_key, scopable, sensitive, deprecated) VALUES (s.code, s.module, s.label_key, s.scopable, s.sensitive, s.deprecated);
MERGE INTO platform.feature t USING (SELECT 'followup.manage' code, 'FOLLOWUP' module, 'feature.followup.manage' label_key, 1 scopable, 0 sensitive, 0 deprecated FROM dual) s ON (t.code = s.code)
WHEN MATCHED THEN UPDATE SET t.module = s.module, t.label_key = s.label_key, t.scopable = s.scopable, t.sensitive = s.sensitive, t.deprecated = s.deprecated
WHEN NOT MATCHED THEN INSERT (code, module, label_key, scopable, sensitive, deprecated) VALUES (s.code, s.module, s.label_key, s.scopable, s.sensitive, s.deprecated);
MERGE INTO platform.feature t USING (SELECT 'mission.create' code, 'MISSION' module, 'feature.mission.create' label_key, 1 scopable, 0 sensitive, 0 deprecated FROM dual) s ON (t.code = s.code)
WHEN MATCHED THEN UPDATE SET t.module = s.module, t.label_key = s.label_key, t.scopable = s.scopable, t.sensitive = s.sensitive, t.deprecated = s.deprecated
WHEN NOT MATCHED THEN INSERT (code, module, label_key, scopable, sensitive, deprecated) VALUES (s.code, s.module, s.label_key, s.scopable, s.sensitive, s.deprecated);
MERGE INTO platform.feature t USING (SELECT 'mission.document.write' code, 'MISSION' module, 'feature.mission.document.write' label_key, 1 scopable, 0 sensitive, 0 deprecated FROM dual) s ON (t.code = s.code)
WHEN MATCHED THEN UPDATE SET t.module = s.module, t.label_key = s.label_key, t.scopable = s.scopable, t.sensitive = s.sensitive, t.deprecated = s.deprecated
WHEN NOT MATCHED THEN INSERT (code, module, label_key, scopable, sensitive, deprecated) VALUES (s.code, s.module, s.label_key, s.scopable, s.sensitive, s.deprecated);
MERGE INTO platform.feature t USING (SELECT 'mission.meeting.write' code, 'MISSION' module, 'feature.mission.meeting.write' label_key, 1 scopable, 0 sensitive, 0 deprecated FROM dual) s ON (t.code = s.code)
WHEN MATCHED THEN UPDATE SET t.module = s.module, t.label_key = s.label_key, t.scopable = s.scopable, t.sensitive = s.sensitive, t.deprecated = s.deprecated
WHEN NOT MATCHED THEN INSERT (code, module, label_key, scopable, sensitive, deprecated) VALUES (s.code, s.module, s.label_key, s.scopable, s.sensitive, s.deprecated);
MERGE INTO platform.feature t USING (SELECT 'mission.order.approve' code, 'MISSION' module, 'feature.mission.order.approve' label_key, 1 scopable, 1 sensitive, 0 deprecated FROM dual) s ON (t.code = s.code)
WHEN MATCHED THEN UPDATE SET t.module = s.module, t.label_key = s.label_key, t.scopable = s.scopable, t.sensitive = s.sensitive, t.deprecated = s.deprecated
WHEN NOT MATCHED THEN INSERT (code, module, label_key, scopable, sensitive, deprecated) VALUES (s.code, s.module, s.label_key, s.scopable, s.sensitive, s.deprecated);
MERGE INTO platform.feature t USING (SELECT 'mission.order.write' code, 'MISSION' module, 'feature.mission.order.write' label_key, 1 scopable, 0 sensitive, 0 deprecated FROM dual) s ON (t.code = s.code)
WHEN MATCHED THEN UPDATE SET t.module = s.module, t.label_key = s.label_key, t.scopable = s.scopable, t.sensitive = s.sensitive, t.deprecated = s.deprecated
WHEN NOT MATCHED THEN INSERT (code, module, label_key, scopable, sensitive, deprecated) VALUES (s.code, s.module, s.label_key, s.scopable, s.sensitive, s.deprecated);
MERGE INTO platform.feature t USING (SELECT 'mission.program.manage' code, 'MISSION' module, 'feature.mission.program.manage' label_key, 1 scopable, 0 sensitive, 0 deprecated FROM dual) s ON (t.code = s.code)
WHEN MATCHED THEN UPDATE SET t.module = s.module, t.label_key = s.label_key, t.scopable = s.scopable, t.sensitive = s.sensitive, t.deprecated = s.deprecated
WHEN NOT MATCHED THEN INSERT (code, module, label_key, scopable, sensitive, deprecated) VALUES (s.code, s.module, s.label_key, s.scopable, s.sensitive, s.deprecated);
MERGE INTO platform.feature t USING (SELECT 'mission.read' code, 'MISSION' module, 'feature.mission.read' label_key, 1 scopable, 0 sensitive, 0 deprecated FROM dual) s ON (t.code = s.code)
WHEN MATCHED THEN UPDATE SET t.module = s.module, t.label_key = s.label_key, t.scopable = s.scopable, t.sensitive = s.sensitive, t.deprecated = s.deprecated
WHEN NOT MATCHED THEN INSERT (code, module, label_key, scopable, sensitive, deprecated) VALUES (s.code, s.module, s.label_key, s.scopable, s.sensitive, s.deprecated);
MERGE INTO platform.feature t USING (SELECT 'mission.schedule.manage' code, 'MISSION' module, 'feature.mission.schedule.manage' label_key, 1 scopable, 0 sensitive, 0 deprecated FROM dual) s ON (t.code = s.code)
WHEN MATCHED THEN UPDATE SET t.module = s.module, t.label_key = s.label_key, t.scopable = s.scopable, t.sensitive = s.sensitive, t.deprecated = s.deprecated
WHEN NOT MATCHED THEN INSERT (code, module, label_key, scopable, sensitive, deprecated) VALUES (s.code, s.module, s.label_key, s.scopable, s.sensitive, s.deprecated);
MERGE INTO platform.feature t USING (SELECT 'mission.team.manage' code, 'MISSION' module, 'feature.mission.team.manage' label_key, 1 scopable, 0 sensitive, 0 deprecated FROM dual) s ON (t.code = s.code)
WHEN MATCHED THEN UPDATE SET t.module = s.module, t.label_key = s.label_key, t.scopable = s.scopable, t.sensitive = s.sensitive, t.deprecated = s.deprecated
WHEN NOT MATCHED THEN INSERT (code, module, label_key, scopable, sensitive, deprecated) VALUES (s.code, s.module, s.label_key, s.scopable, s.sensitive, s.deprecated);
MERGE INTO platform.feature t USING (SELECT 'mission.update' code, 'MISSION' module, 'feature.mission.update' label_key, 1 scopable, 0 sensitive, 0 deprecated FROM dual) s ON (t.code = s.code)
WHEN MATCHED THEN UPDATE SET t.module = s.module, t.label_key = s.label_key, t.scopable = s.scopable, t.sensitive = s.sensitive, t.deprecated = s.deprecated
WHEN NOT MATCHED THEN INSERT (code, module, label_key, scopable, sensitive, deprecated) VALUES (s.code, s.module, s.label_key, s.scopable, s.sensitive, s.deprecated);
MERGE INTO platform.feature t USING (SELECT 'ops.ai.manage' code, 'OPS' module, 'feature.ops.ai.manage' label_key, 1 scopable, 1 sensitive, 0 deprecated FROM dual) s ON (t.code = s.code)
WHEN MATCHED THEN UPDATE SET t.module = s.module, t.label_key = s.label_key, t.scopable = s.scopable, t.sensitive = s.sensitive, t.deprecated = s.deprecated
WHEN NOT MATCHED THEN INSERT (code, module, label_key, scopable, sensitive, deprecated) VALUES (s.code, s.module, s.label_key, s.scopable, s.sensitive, s.deprecated);
MERGE INTO platform.feature t USING (SELECT 'ops.audittrail.read' code, 'OPS' module, 'feature.ops.audittrail.read' label_key, 1 scopable, 0 sensitive, 0 deprecated FROM dual) s ON (t.code = s.code)
WHEN MATCHED THEN UPDATE SET t.module = s.module, t.label_key = s.label_key, t.scopable = s.scopable, t.sensitive = s.sensitive, t.deprecated = s.deprecated
WHEN NOT MATCHED THEN INSERT (code, module, label_key, scopable, sensitive, deprecated) VALUES (s.code, s.module, s.label_key, s.scopable, s.sensitive, s.deprecated);
MERGE INTO platform.feature t USING (SELECT 'ops.audittrail.verify' code, 'OPS' module, 'feature.ops.audittrail.verify' label_key, 1 scopable, 1 sensitive, 0 deprecated FROM dual) s ON (t.code = s.code)
WHEN MATCHED THEN UPDATE SET t.module = s.module, t.label_key = s.label_key, t.scopable = s.scopable, t.sensitive = s.sensitive, t.deprecated = s.deprecated
WHEN NOT MATCHED THEN INSERT (code, module, label_key, scopable, sensitive, deprecated) VALUES (s.code, s.module, s.label_key, s.scopable, s.sensitive, s.deprecated);
MERGE INTO platform.feature t USING (SELECT 'ops.config.transfer' code, 'OPS' module, 'feature.ops.config.transfer' label_key, 1 scopable, 1 sensitive, 0 deprecated FROM dual) s ON (t.code = s.code)
WHEN MATCHED THEN UPDATE SET t.module = s.module, t.label_key = s.label_key, t.scopable = s.scopable, t.sensitive = s.sensitive, t.deprecated = s.deprecated
WHEN NOT MATCHED THEN INSERT (code, module, label_key, scopable, sensitive, deprecated) VALUES (s.code, s.module, s.label_key, s.scopable, s.sensitive, s.deprecated);
MERGE INTO platform.feature t USING (SELECT 'ops.connector.manage' code, 'OPS' module, 'feature.ops.connector.manage' label_key, 1 scopable, 1 sensitive, 0 deprecated FROM dual) s ON (t.code = s.code)
WHEN MATCHED THEN UPDATE SET t.module = s.module, t.label_key = s.label_key, t.scopable = s.scopable, t.sensitive = s.sensitive, t.deprecated = s.deprecated
WHEN NOT MATCHED THEN INSERT (code, module, label_key, scopable, sensitive, deprecated) VALUES (s.code, s.module, s.label_key, s.scopable, s.sensitive, s.deprecated);
MERGE INTO platform.feature t USING (SELECT 'ops.connector.read' code, 'OPS' module, 'feature.ops.connector.read' label_key, 1 scopable, 0 sensitive, 0 deprecated FROM dual) s ON (t.code = s.code)
WHEN MATCHED THEN UPDATE SET t.module = s.module, t.label_key = s.label_key, t.scopable = s.scopable, t.sensitive = s.sensitive, t.deprecated = s.deprecated
WHEN NOT MATCHED THEN INSERT (code, module, label_key, scopable, sensitive, deprecated) VALUES (s.code, s.module, s.label_key, s.scopable, s.sensitive, s.deprecated);
MERGE INTO platform.feature t USING (SELECT 'ops.export.manage' code, 'OPS' module, 'feature.ops.export.manage' label_key, 1 scopable, 1 sensitive, 0 deprecated FROM dual) s ON (t.code = s.code)
WHEN MATCHED THEN UPDATE SET t.module = s.module, t.label_key = s.label_key, t.scopable = s.scopable, t.sensitive = s.sensitive, t.deprecated = s.deprecated
WHEN NOT MATCHED THEN INSERT (code, module, label_key, scopable, sensitive, deprecated) VALUES (s.code, s.module, s.label_key, s.scopable, s.sensitive, s.deprecated);
MERGE INTO platform.feature t USING (SELECT 'ops.health.read' code, 'OPS' module, 'feature.ops.health.read' label_key, 1 scopable, 0 sensitive, 0 deprecated FROM dual) s ON (t.code = s.code)
WHEN MATCHED THEN UPDATE SET t.module = s.module, t.label_key = s.label_key, t.scopable = s.scopable, t.sensitive = s.sensitive, t.deprecated = s.deprecated
WHEN NOT MATCHED THEN INSERT (code, module, label_key, scopable, sensitive, deprecated) VALUES (s.code, s.module, s.label_key, s.scopable, s.sensitive, s.deprecated);
MERGE INTO platform.feature t USING (SELECT 'ops.import.manage' code, 'OPS' module, 'feature.ops.import.manage' label_key, 1 scopable, 1 sensitive, 0 deprecated FROM dual) s ON (t.code = s.code)
WHEN MATCHED THEN UPDATE SET t.module = s.module, t.label_key = s.label_key, t.scopable = s.scopable, t.sensitive = s.sensitive, t.deprecated = s.deprecated
WHEN NOT MATCHED THEN INSERT (code, module, label_key, scopable, sensitive, deprecated) VALUES (s.code, s.module, s.label_key, s.scopable, s.sensitive, s.deprecated);
MERGE INTO platform.feature t USING (SELECT 'ops.job.manage' code, 'OPS' module, 'feature.ops.job.manage' label_key, 1 scopable, 0 sensitive, 0 deprecated FROM dual) s ON (t.code = s.code)
WHEN MATCHED THEN UPDATE SET t.module = s.module, t.label_key = s.label_key, t.scopable = s.scopable, t.sensitive = s.sensitive, t.deprecated = s.deprecated
WHEN NOT MATCHED THEN INSERT (code, module, label_key, scopable, sensitive, deprecated) VALUES (s.code, s.module, s.label_key, s.scopable, s.sensitive, s.deprecated);
MERGE INTO platform.feature t USING (SELECT 'ops.license.manage' code, 'OPS' module, 'feature.ops.license.manage' label_key, 1 scopable, 1 sensitive, 0 deprecated FROM dual) s ON (t.code = s.code)
WHEN MATCHED THEN UPDATE SET t.module = s.module, t.label_key = s.label_key, t.scopable = s.scopable, t.sensitive = s.sensitive, t.deprecated = s.deprecated
WHEN NOT MATCHED THEN INSERT (code, module, label_key, scopable, sensitive, deprecated) VALUES (s.code, s.module, s.label_key, s.scopable, s.sensitive, s.deprecated);
MERGE INTO platform.feature t USING (SELECT 'ops.pack.manage' code, 'OPS' module, 'feature.ops.pack.manage' label_key, 1 scopable, 1 sensitive, 0 deprecated FROM dual) s ON (t.code = s.code)
WHEN MATCHED THEN UPDATE SET t.module = s.module, t.label_key = s.label_key, t.scopable = s.scopable, t.sensitive = s.sensitive, t.deprecated = s.deprecated
WHEN NOT MATCHED THEN INSERT (code, module, label_key, scopable, sensitive, deprecated) VALUES (s.code, s.module, s.label_key, s.scopable, s.sensitive, s.deprecated);
MERGE INTO platform.feature t USING (SELECT 'ops.retention.manage' code, 'OPS' module, 'feature.ops.retention.manage' label_key, 1 scopable, 1 sensitive, 0 deprecated FROM dual) s ON (t.code = s.code)
WHEN MATCHED THEN UPDATE SET t.module = s.module, t.label_key = s.label_key, t.scopable = s.scopable, t.sensitive = s.sensitive, t.deprecated = s.deprecated
WHEN NOT MATCHED THEN INSERT (code, module, label_key, scopable, sensitive, deprecated) VALUES (s.code, s.module, s.label_key, s.scopable, s.sensitive, s.deprecated);
MERGE INTO platform.feature t USING (SELECT 'ops.retention.read' code, 'OPS' module, 'feature.ops.retention.read' label_key, 1 scopable, 0 sensitive, 0 deprecated FROM dual) s ON (t.code = s.code)
WHEN MATCHED THEN UPDATE SET t.module = s.module, t.label_key = s.label_key, t.scopable = s.scopable, t.sensitive = s.sensitive, t.deprecated = s.deprecated
WHEN NOT MATCHED THEN INSERT (code, module, label_key, scopable, sensitive, deprecated) VALUES (s.code, s.module, s.label_key, s.scopable, s.sensitive, s.deprecated);
MERGE INTO platform.feature t USING (SELECT 'ops.signature-provider.manage' code, 'OPS' module, 'feature.ops.signature-provider.manage' label_key, 1 scopable, 1 sensitive, 0 deprecated FROM dual) s ON (t.code = s.code)
WHEN MATCHED THEN UPDATE SET t.module = s.module, t.label_key = s.label_key, t.scopable = s.scopable, t.sensitive = s.sensitive, t.deprecated = s.deprecated
WHEN NOT MATCHED THEN INSERT (code, module, label_key, scopable, sensitive, deprecated) VALUES (s.code, s.module, s.label_key, s.scopable, s.sensitive, s.deprecated);
MERGE INTO platform.feature t USING (SELECT 'ops.support.approve' code, 'OPS' module, 'feature.ops.support.approve' label_key, 1 scopable, 1 sensitive, 0 deprecated FROM dual) s ON (t.code = s.code)
WHEN MATCHED THEN UPDATE SET t.module = s.module, t.label_key = s.label_key, t.scopable = s.scopable, t.sensitive = s.sensitive, t.deprecated = s.deprecated
WHEN NOT MATCHED THEN INSERT (code, module, label_key, scopable, sensitive, deprecated) VALUES (s.code, s.module, s.label_key, s.scopable, s.sensitive, s.deprecated);
MERGE INTO platform.feature t USING (SELECT 'ops.support.request' code, 'OPS' module, 'feature.ops.support.request' label_key, 1 scopable, 0 sensitive, 0 deprecated FROM dual) s ON (t.code = s.code)
WHEN MATCHED THEN UPDATE SET t.module = s.module, t.label_key = s.label_key, t.scopable = s.scopable, t.sensitive = s.sensitive, t.deprecated = s.deprecated
WHEN NOT MATCHED THEN INSERT (code, module, label_key, scopable, sensitive, deprecated) VALUES (s.code, s.module, s.label_key, s.scopable, s.sensitive, s.deprecated);
MERGE INTO platform.feature t USING (SELECT 'ops.theme.manage' code, 'OPS' module, 'feature.ops.theme.manage' label_key, 1 scopable, 0 sensitive, 0 deprecated FROM dual) s ON (t.code = s.code)
WHEN MATCHED THEN UPDATE SET t.module = s.module, t.label_key = s.label_key, t.scopable = s.scopable, t.sensitive = s.sensitive, t.deprecated = s.deprecated
WHEN NOT MATCHED THEN INSERT (code, module, label_key, scopable, sensitive, deprecated) VALUES (s.code, s.module, s.label_key, s.scopable, s.sensitive, s.deprecated);
MERGE INTO platform.feature t USING (SELECT 'ops.workflow.deploy' code, 'OPS' module, 'feature.ops.workflow.deploy' label_key, 1 scopable, 1 sensitive, 0 deprecated FROM dual) s ON (t.code = s.code)
WHEN MATCHED THEN UPDATE SET t.module = s.module, t.label_key = s.label_key, t.scopable = s.scopable, t.sensitive = s.sensitive, t.deprecated = s.deprecated
WHEN NOT MATCHED THEN INSERT (code, module, label_key, scopable, sensitive, deprecated) VALUES (s.code, s.module, s.label_key, s.scopable, s.sensitive, s.deprecated);
MERGE INTO platform.feature t USING (SELECT 'ops.workflow.operate' code, 'OPS' module, 'feature.ops.workflow.operate' label_key, 1 scopable, 1 sensitive, 0 deprecated FROM dual) s ON (t.code = s.code)
WHEN MATCHED THEN UPDATE SET t.module = s.module, t.label_key = s.label_key, t.scopable = s.scopable, t.sensitive = s.sensitive, t.deprecated = s.deprecated
WHEN NOT MATCHED THEN INSERT (code, module, label_key, scopable, sensitive, deprecated) VALUES (s.code, s.module, s.label_key, s.scopable, s.sensitive, s.deprecated);
MERGE INTO platform.feature t USING (SELECT 'plan.approve' code, 'PLAN' module, 'feature.plan.approve' label_key, 1 scopable, 1 sensitive, 0 deprecated FROM dual) s ON (t.code = s.code)
WHEN MATCHED THEN UPDATE SET t.module = s.module, t.label_key = s.label_key, t.scopable = s.scopable, t.sensitive = s.sensitive, t.deprecated = s.deprecated
WHEN NOT MATCHED THEN INSERT (code, module, label_key, scopable, sensitive, deprecated) VALUES (s.code, s.module, s.label_key, s.scopable, s.sensitive, s.deprecated);
MERGE INTO platform.feature t USING (SELECT 'plan.manage' code, 'PLAN' module, 'feature.plan.manage' label_key, 1 scopable, 0 sensitive, 0 deprecated FROM dual) s ON (t.code = s.code)
WHEN MATCHED THEN UPDATE SET t.module = s.module, t.label_key = s.label_key, t.scopable = s.scopable, t.sensitive = s.sensitive, t.deprecated = s.deprecated
WHEN NOT MATCHED THEN INSERT (code, module, label_key, scopable, sensitive, deprecated) VALUES (s.code, s.module, s.label_key, s.scopable, s.sensitive, s.deprecated);
MERGE INTO platform.feature t USING (SELECT 'plan.read' code, 'PLAN' module, 'feature.plan.read' label_key, 1 scopable, 0 sensitive, 0 deprecated FROM dual) s ON (t.code = s.code)
WHEN MATCHED THEN UPDATE SET t.module = s.module, t.label_key = s.label_key, t.scopable = s.scopable, t.sensitive = s.sensitive, t.deprecated = s.deprecated
WHEN NOT MATCHED THEN INSERT (code, module, label_key, scopable, sensitive, deprecated) VALUES (s.code, s.module, s.label_key, s.scopable, s.sensitive, s.deprecated);
MERGE INTO platform.feature t USING (SELECT 'quality.manage' code, 'QUALITY' module, 'feature.quality.manage' label_key, 1 scopable, 0 sensitive, 0 deprecated FROM dual) s ON (t.code = s.code)
WHEN MATCHED THEN UPDATE SET t.module = s.module, t.label_key = s.label_key, t.scopable = s.scopable, t.sensitive = s.sensitive, t.deprecated = s.deprecated
WHEN NOT MATCHED THEN INSERT (code, module, label_key, scopable, sensitive, deprecated) VALUES (s.code, s.module, s.label_key, s.scopable, s.sensitive, s.deprecated);
MERGE INTO platform.feature t USING (SELECT 'quality.read' code, 'QUALITY' module, 'feature.quality.read' label_key, 1 scopable, 0 sensitive, 0 deprecated FROM dual) s ON (t.code = s.code)
WHEN MATCHED THEN UPDATE SET t.module = s.module, t.label_key = s.label_key, t.scopable = s.scopable, t.sensitive = s.sensitive, t.deprecated = s.deprecated
WHEN NOT MATCHED THEN INSERT (code, module, label_key, scopable, sensitive, deprecated) VALUES (s.code, s.module, s.label_key, s.scopable, s.sensitive, s.deprecated);
MERGE INTO platform.feature t USING (SELECT 'questionnaire.campaign.manage' code, 'QUESTIONNAIRE' module, 'feature.questionnaire.campaign.manage' label_key, 1 scopable, 0 sensitive, 0 deprecated FROM dual) s ON (t.code = s.code)
WHEN MATCHED THEN UPDATE SET t.module = s.module, t.label_key = s.label_key, t.scopable = s.scopable, t.sensitive = s.sensitive, t.deprecated = s.deprecated
WHEN NOT MATCHED THEN INSERT (code, module, label_key, scopable, sensitive, deprecated) VALUES (s.code, s.module, s.label_key, s.scopable, s.sensitive, s.deprecated);
MERGE INTO platform.feature t USING (SELECT 'questionnaire.template.manage' code, 'QUESTIONNAIRE' module, 'feature.questionnaire.template.manage' label_key, 1 scopable, 0 sensitive, 0 deprecated FROM dual) s ON (t.code = s.code)
WHEN MATCHED THEN UPDATE SET t.module = s.module, t.label_key = s.label_key, t.scopable = s.scopable, t.sensitive = s.sensitive, t.deprecated = s.deprecated
WHEN NOT MATCHED THEN INSERT (code, module, label_key, scopable, sensitive, deprecated) VALUES (s.code, s.module, s.label_key, s.scopable, s.sensitive, s.deprecated);
MERGE INTO platform.feature t USING (SELECT 'recommendation.close' code, 'RECOMMENDATION' module, 'feature.recommendation.close' label_key, 1 scopable, 1 sensitive, 0 deprecated FROM dual) s ON (t.code = s.code)
WHEN MATCHED THEN UPDATE SET t.module = s.module, t.label_key = s.label_key, t.scopable = s.scopable, t.sensitive = s.sensitive, t.deprecated = s.deprecated
WHEN NOT MATCHED THEN INSERT (code, module, label_key, scopable, sensitive, deprecated) VALUES (s.code, s.module, s.label_key, s.scopable, s.sensitive, s.deprecated);
MERGE INTO platform.feature t USING (SELECT 'recommendation.manage' code, 'RECOMMENDATION' module, 'feature.recommendation.manage' label_key, 1 scopable, 0 sensitive, 0 deprecated FROM dual) s ON (t.code = s.code)
WHEN MATCHED THEN UPDATE SET t.module = s.module, t.label_key = s.label_key, t.scopable = s.scopable, t.sensitive = s.sensitive, t.deprecated = s.deprecated
WHEN NOT MATCHED THEN INSERT (code, module, label_key, scopable, sensitive, deprecated) VALUES (s.code, s.module, s.label_key, s.scopable, s.sensitive, s.deprecated);
MERGE INTO platform.feature t USING (SELECT 'recommendation.read' code, 'RECOMMENDATION' module, 'feature.recommendation.read' label_key, 1 scopable, 0 sensitive, 0 deprecated FROM dual) s ON (t.code = s.code)
WHEN MATCHED THEN UPDATE SET t.module = s.module, t.label_key = s.label_key, t.scopable = s.scopable, t.sensitive = s.sensitive, t.deprecated = s.deprecated
WHEN NOT MATCHED THEN INSERT (code, module, label_key, scopable, sensitive, deprecated) VALUES (s.code, s.module, s.label_key, s.scopable, s.sensitive, s.deprecated);
MERGE INTO platform.feature t USING (SELECT 'report.contradictory.manage' code, 'REPORT' module, 'feature.report.contradictory.manage' label_key, 1 scopable, 0 sensitive, 0 deprecated FROM dual) s ON (t.code = s.code)
WHEN MATCHED THEN UPDATE SET t.module = s.module, t.label_key = s.label_key, t.scopable = s.scopable, t.sensitive = s.sensitive, t.deprecated = s.deprecated
WHEN NOT MATCHED THEN INSERT (code, module, label_key, scopable, sensitive, deprecated) VALUES (s.code, s.module, s.label_key, s.scopable, s.sensitive, s.deprecated);
MERGE INTO platform.feature t USING (SELECT 'report.distribute' code, 'REPORT' module, 'feature.report.distribute' label_key, 1 scopable, 0 sensitive, 0 deprecated FROM dual) s ON (t.code = s.code)
WHEN MATCHED THEN UPDATE SET t.module = s.module, t.label_key = s.label_key, t.scopable = s.scopable, t.sensitive = s.sensitive, t.deprecated = s.deprecated
WHEN NOT MATCHED THEN INSERT (code, module, label_key, scopable, sensitive, deprecated) VALUES (s.code, s.module, s.label_key, s.scopable, s.sensitive, s.deprecated);
MERGE INTO platform.feature t USING (SELECT 'report.final.approve' code, 'REPORT' module, 'feature.report.final.approve' label_key, 1 scopable, 1 sensitive, 0 deprecated FROM dual) s ON (t.code = s.code)
WHEN MATCHED THEN UPDATE SET t.module = s.module, t.label_key = s.label_key, t.scopable = s.scopable, t.sensitive = s.sensitive, t.deprecated = s.deprecated
WHEN NOT MATCHED THEN INSERT (code, module, label_key, scopable, sensitive, deprecated) VALUES (s.code, s.module, s.label_key, s.scopable, s.sensitive, s.deprecated);
MERGE INTO platform.feature t USING (SELECT 'report.final.generate' code, 'REPORT' module, 'feature.report.final.generate' label_key, 1 scopable, 0 sensitive, 0 deprecated FROM dual) s ON (t.code = s.code)
WHEN MATCHED THEN UPDATE SET t.module = s.module, t.label_key = s.label_key, t.scopable = s.scopable, t.sensitive = s.sensitive, t.deprecated = s.deprecated
WHEN NOT MATCHED THEN INSERT (code, module, label_key, scopable, sensitive, deprecated) VALUES (s.code, s.module, s.label_key, s.scopable, s.sensitive, s.deprecated);
MERGE INTO platform.feature t USING (SELECT 'report.read' code, 'REPORT' module, 'feature.report.read' label_key, 1 scopable, 0 sensitive, 0 deprecated FROM dual) s ON (t.code = s.code)
WHEN MATCHED THEN UPDATE SET t.module = s.module, t.label_key = s.label_key, t.scopable = s.scopable, t.sensitive = s.sensitive, t.deprecated = s.deprecated
WHEN NOT MATCHED THEN INSERT (code, module, label_key, scopable, sensitive, deprecated) VALUES (s.code, s.module, s.label_key, s.scopable, s.sensitive, s.deprecated);
MERGE INTO platform.feature t USING (SELECT 'report.write' code, 'REPORT' module, 'feature.report.write' label_key, 1 scopable, 0 sensitive, 0 deprecated FROM dual) s ON (t.code = s.code)
WHEN MATCHED THEN UPDATE SET t.module = s.module, t.label_key = s.label_key, t.scopable = s.scopable, t.sensitive = s.sensitive, t.deprecated = s.deprecated
WHEN NOT MATCHED THEN INSERT (code, module, label_key, scopable, sensitive, deprecated) VALUES (s.code, s.module, s.label_key, s.scopable, s.sensitive, s.deprecated);
MERGE INTO platform.feature t USING (SELECT 'reporting.committee.manage' code, 'REPORTING' module, 'feature.reporting.committee.manage' label_key, 1 scopable, 0 sensitive, 0 deprecated FROM dual) s ON (t.code = s.code)
WHEN MATCHED THEN UPDATE SET t.module = s.module, t.label_key = s.label_key, t.scopable = s.scopable, t.sensitive = s.sensitive, t.deprecated = s.deprecated
WHEN NOT MATCHED THEN INSERT (code, module, label_key, scopable, sensitive, deprecated) VALUES (s.code, s.module, s.label_key, s.scopable, s.sensitive, s.deprecated);
MERGE INTO platform.feature t USING (SELECT 'reporting.dashboard.read' code, 'REPORTING' module, 'feature.reporting.dashboard.read' label_key, 1 scopable, 0 sensitive, 0 deprecated FROM dual) s ON (t.code = s.code)
WHEN MATCHED THEN UPDATE SET t.module = s.module, t.label_key = s.label_key, t.scopable = s.scopable, t.sensitive = s.sensitive, t.deprecated = s.deprecated
WHEN NOT MATCHED THEN INSERT (code, module, label_key, scopable, sensitive, deprecated) VALUES (s.code, s.module, s.label_key, s.scopable, s.sensitive, s.deprecated);
MERGE INTO platform.feature t USING (SELECT 'reporting.export' code, 'REPORTING' module, 'feature.reporting.export' label_key, 1 scopable, 0 sensitive, 0 deprecated FROM dual) s ON (t.code = s.code)
WHEN MATCHED THEN UPDATE SET t.module = s.module, t.label_key = s.label_key, t.scopable = s.scopable, t.sensitive = s.sensitive, t.deprecated = s.deprecated
WHEN NOT MATCHED THEN INSERT (code, module, label_key, scopable, sensitive, deprecated) VALUES (s.code, s.module, s.label_key, s.scopable, s.sensitive, s.deprecated);
MERGE INTO platform.feature t USING (SELECT 'reporting.regulator.manage' code, 'REPORTING' module, 'feature.reporting.regulator.manage' label_key, 1 scopable, 0 sensitive, 0 deprecated FROM dual) s ON (t.code = s.code)
WHEN MATCHED THEN UPDATE SET t.module = s.module, t.label_key = s.label_key, t.scopable = s.scopable, t.sensitive = s.sensitive, t.deprecated = s.deprecated
WHEN NOT MATCHED THEN INSERT (code, module, label_key, scopable, sensitive, deprecated) VALUES (s.code, s.module, s.label_key, s.scopable, s.sensitive, s.deprecated);
MERGE INTO platform.feature t USING (SELECT 'request.manage' code, 'REQUEST' module, 'feature.request.manage' label_key, 1 scopable, 0 sensitive, 0 deprecated FROM dual) s ON (t.code = s.code)
WHEN MATCHED THEN UPDATE SET t.module = s.module, t.label_key = s.label_key, t.scopable = s.scopable, t.sensitive = s.sensitive, t.deprecated = s.deprecated
WHEN NOT MATCHED THEN INSERT (code, module, label_key, scopable, sensitive, deprecated) VALUES (s.code, s.module, s.label_key, s.scopable, s.sensitive, s.deprecated);
MERGE INTO platform.feature t USING (SELECT 'request.read' code, 'REQUEST' module, 'feature.request.read' label_key, 1 scopable, 0 sensitive, 0 deprecated FROM dual) s ON (t.code = s.code)
WHEN MATCHED THEN UPDATE SET t.module = s.module, t.label_key = s.label_key, t.scopable = s.scopable, t.sensitive = s.sensitive, t.deprecated = s.deprecated
WHEN NOT MATCHED THEN INSERT (code, module, label_key, scopable, sensitive, deprecated) VALUES (s.code, s.module, s.label_key, s.scopable, s.sensitive, s.deprecated);
MERGE INTO platform.feature t USING (SELECT 'resource.manage' code, 'RESOURCE' module, 'feature.resource.manage' label_key, 1 scopable, 0 sensitive, 0 deprecated FROM dual) s ON (t.code = s.code)
WHEN MATCHED THEN UPDATE SET t.module = s.module, t.label_key = s.label_key, t.scopable = s.scopable, t.sensitive = s.sensitive, t.deprecated = s.deprecated
WHEN NOT MATCHED THEN INSERT (code, module, label_key, scopable, sensitive, deprecated) VALUES (s.code, s.module, s.label_key, s.scopable, s.sensitive, s.deprecated);
MERGE INTO platform.feature t USING (SELECT 'resource.read' code, 'RESOURCE' module, 'feature.resource.read' label_key, 1 scopable, 0 sensitive, 0 deprecated FROM dual) s ON (t.code = s.code)
WHEN MATCHED THEN UPDATE SET t.module = s.module, t.label_key = s.label_key, t.scopable = s.scopable, t.sensitive = s.sensitive, t.deprecated = s.deprecated
WHEN NOT MATCHED THEN INSERT (code, module, label_key, scopable, sensitive, deprecated) VALUES (s.code, s.module, s.label_key, s.scopable, s.sensitive, s.deprecated);
MERGE INTO platform.feature t USING (SELECT 'risk.assessment.manage' code, 'RISK' module, 'feature.risk.assessment.manage' label_key, 1 scopable, 0 sensitive, 0 deprecated FROM dual) s ON (t.code = s.code)
WHEN MATCHED THEN UPDATE SET t.module = s.module, t.label_key = s.label_key, t.scopable = s.scopable, t.sensitive = s.sensitive, t.deprecated = s.deprecated
WHEN NOT MATCHED THEN INSERT (code, module, label_key, scopable, sensitive, deprecated) VALUES (s.code, s.module, s.label_key, s.scopable, s.sensitive, s.deprecated);
MERGE INTO platform.feature t USING (SELECT 'risk.assessment.read' code, 'RISK' module, 'feature.risk.assessment.read' label_key, 1 scopable, 0 sensitive, 0 deprecated FROM dual) s ON (t.code = s.code)
WHEN MATCHED THEN UPDATE SET t.module = s.module, t.label_key = s.label_key, t.scopable = s.scopable, t.sensitive = s.sensitive, t.deprecated = s.deprecated
WHEN NOT MATCHED THEN INSERT (code, module, label_key, scopable, sensitive, deprecated) VALUES (s.code, s.module, s.label_key, s.scopable, s.sensitive, s.deprecated);
MERGE INTO platform.feature t USING (SELECT 'settings.charter.manage' code, 'SETTINGS' module, 'feature.settings.charter.manage' label_key, 1 scopable, 1 sensitive, 0 deprecated FROM dual) s ON (t.code = s.code)
WHEN MATCHED THEN UPDATE SET t.module = s.module, t.label_key = s.label_key, t.scopable = s.scopable, t.sensitive = s.sensitive, t.deprecated = s.deprecated
WHEN NOT MATCHED THEN INSERT (code, module, label_key, scopable, sensitive, deprecated) VALUES (s.code, s.module, s.label_key, s.scopable, s.sensitive, s.deprecated);
MERGE INTO platform.feature t USING (SELECT 'settings.independence.manage' code, 'SETTINGS' module, 'feature.settings.independence.manage' label_key, 1 scopable, 0 sensitive, 0 deprecated FROM dual) s ON (t.code = s.code)
WHEN MATCHED THEN UPDATE SET t.module = s.module, t.label_key = s.label_key, t.scopable = s.scopable, t.sensitive = s.sensitive, t.deprecated = s.deprecated
WHEN NOT MATCHED THEN INSERT (code, module, label_key, scopable, sensitive, deprecated) VALUES (s.code, s.module, s.label_key, s.scopable, s.sensitive, s.deprecated);
MERGE INTO platform.feature t USING (SELECT 'settings.indicator.manage' code, 'SETTINGS' module, 'feature.settings.indicator.manage' label_key, 1 scopable, 0 sensitive, 0 deprecated FROM dual) s ON (t.code = s.code)
WHEN MATCHED THEN UPDATE SET t.module = s.module, t.label_key = s.label_key, t.scopable = s.scopable, t.sensitive = s.sensitive, t.deprecated = s.deprecated
WHEN NOT MATCHED THEN INSERT (code, module, label_key, scopable, sensitive, deprecated) VALUES (s.code, s.module, s.label_key, s.scopable, s.sensitive, s.deprecated);
MERGE INTO platform.feature t USING (SELECT 'settings.notification.manage' code, 'SETTINGS' module, 'feature.settings.notification.manage' label_key, 1 scopable, 0 sensitive, 0 deprecated FROM dual) s ON (t.code = s.code)
WHEN MATCHED THEN UPDATE SET t.module = s.module, t.label_key = s.label_key, t.scopable = s.scopable, t.sensitive = s.sensitive, t.deprecated = s.deprecated
WHEN NOT MATCHED THEN INSERT (code, module, label_key, scopable, sensitive, deprecated) VALUES (s.code, s.module, s.label_key, s.scopable, s.sensitive, s.deprecated);
MERGE INTO platform.feature t USING (SELECT 'settings.publication.approve' code, 'SETTINGS' module, 'feature.settings.publication.approve' label_key, 1 scopable, 1 sensitive, 0 deprecated FROM dual) s ON (t.code = s.code)
WHEN MATCHED THEN UPDATE SET t.module = s.module, t.label_key = s.label_key, t.scopable = s.scopable, t.sensitive = s.sensitive, t.deprecated = s.deprecated
WHEN NOT MATCHED THEN INSERT (code, module, label_key, scopable, sensitive, deprecated) VALUES (s.code, s.module, s.label_key, s.scopable, s.sensitive, s.deprecated);
MERGE INTO platform.feature t USING (SELECT 'settings.read' code, 'SETTINGS' module, 'feature.settings.read' label_key, 1 scopable, 0 sensitive, 0 deprecated FROM dual) s ON (t.code = s.code)
WHEN MATCHED THEN UPDATE SET t.module = s.module, t.label_key = s.label_key, t.scopable = s.scopable, t.sensitive = s.sensitive, t.deprecated = s.deprecated
WHEN NOT MATCHED THEN INSERT (code, module, label_key, scopable, sensitive, deprecated) VALUES (s.code, s.module, s.label_key, s.scopable, s.sensitive, s.deprecated);
MERGE INTO platform.feature t USING (SELECT 'settings.referential.manage' code, 'SETTINGS' module, 'feature.settings.referential.manage' label_key, 1 scopable, 0 sensitive, 0 deprecated FROM dual) s ON (t.code = s.code)
WHEN MATCHED THEN UPDATE SET t.module = s.module, t.label_key = s.label_key, t.scopable = s.scopable, t.sensitive = s.sensitive, t.deprecated = s.deprecated
WHEN NOT MATCHED THEN INSERT (code, module, label_key, scopable, sensitive, deprecated) VALUES (s.code, s.module, s.label_key, s.scopable, s.sensitive, s.deprecated);
MERGE INTO platform.feature t USING (SELECT 'settings.signature.manage' code, 'SETTINGS' module, 'feature.settings.signature.manage' label_key, 1 scopable, 0 sensitive, 0 deprecated FROM dual) s ON (t.code = s.code)
WHEN MATCHED THEN UPDATE SET t.module = s.module, t.label_key = s.label_key, t.scopable = s.scopable, t.sensitive = s.sensitive, t.deprecated = s.deprecated
WHEN NOT MATCHED THEN INSERT (code, module, label_key, scopable, sensitive, deprecated) VALUES (s.code, s.module, s.label_key, s.scopable, s.sensitive, s.deprecated);
MERGE INTO platform.feature t USING (SELECT 'settings.template.manage' code, 'SETTINGS' module, 'feature.settings.template.manage' label_key, 1 scopable, 0 sensitive, 0 deprecated FROM dual) s ON (t.code = s.code)
WHEN MATCHED THEN UPDATE SET t.module = s.module, t.label_key = s.label_key, t.scopable = s.scopable, t.sensitive = s.sensitive, t.deprecated = s.deprecated
WHEN NOT MATCHED THEN INSERT (code, module, label_key, scopable, sensitive, deprecated) VALUES (s.code, s.module, s.label_key, s.scopable, s.sensitive, s.deprecated);
MERGE INTO platform.feature t USING (SELECT 'settings.ui.manage' code, 'SETTINGS' module, 'feature.settings.ui.manage' label_key, 1 scopable, 0 sensitive, 0 deprecated FROM dual) s ON (t.code = s.code)
WHEN MATCHED THEN UPDATE SET t.module = s.module, t.label_key = s.label_key, t.scopable = s.scopable, t.sensitive = s.sensitive, t.deprecated = s.deprecated
WHEN NOT MATCHED THEN INSERT (code, module, label_key, scopable, sensitive, deprecated) VALUES (s.code, s.module, s.label_key, s.scopable, s.sensitive, s.deprecated);
MERGE INTO platform.feature t USING (SELECT 'settings.workflow.manage' code, 'SETTINGS' module, 'feature.settings.workflow.manage' label_key, 1 scopable, 0 sensitive, 0 deprecated FROM dual) s ON (t.code = s.code)
WHEN MATCHED THEN UPDATE SET t.module = s.module, t.label_key = s.label_key, t.scopable = s.scopable, t.sensitive = s.sensitive, t.deprecated = s.deprecated
WHEN NOT MATCHED THEN INSERT (code, module, label_key, scopable, sensitive, deprecated) VALUES (s.code, s.module, s.label_key, s.scopable, s.sensitive, s.deprecated);
MERGE INTO platform.feature t USING (SELECT 'signature.inbox' code, 'SIGNATURE' module, 'feature.signature.inbox' label_key, 1 scopable, 0 sensitive, 0 deprecated FROM dual) s ON (t.code = s.code)
WHEN MATCHED THEN UPDATE SET t.module = s.module, t.label_key = s.label_key, t.scopable = s.scopable, t.sensitive = s.sensitive, t.deprecated = s.deprecated
WHEN NOT MATCHED THEN INSERT (code, module, label_key, scopable, sensitive, deprecated) VALUES (s.code, s.module, s.label_key, s.scopable, s.sensitive, s.deprecated);
MERGE INTO platform.feature t USING (SELECT 'signature.register.read' code, 'SIGNATURE' module, 'feature.signature.register.read' label_key, 1 scopable, 0 sensitive, 0 deprecated FROM dual) s ON (t.code = s.code)
WHEN MATCHED THEN UPDATE SET t.module = s.module, t.label_key = s.label_key, t.scopable = s.scopable, t.sensitive = s.sensitive, t.deprecated = s.deprecated
WHEN NOT MATCHED THEN INSERT (code, module, label_key, scopable, sensitive, deprecated) VALUES (s.code, s.module, s.label_key, s.scopable, s.sensitive, s.deprecated);
MERGE INTO platform.feature t USING (SELECT 'timesheet.approve' code, 'TIMESHEET' module, 'feature.timesheet.approve' label_key, 1 scopable, 0 sensitive, 0 deprecated FROM dual) s ON (t.code = s.code)
WHEN MATCHED THEN UPDATE SET t.module = s.module, t.label_key = s.label_key, t.scopable = s.scopable, t.sensitive = s.sensitive, t.deprecated = s.deprecated
WHEN NOT MATCHED THEN INSERT (code, module, label_key, scopable, sensitive, deprecated) VALUES (s.code, s.module, s.label_key, s.scopable, s.sensitive, s.deprecated);
MERGE INTO platform.feature t USING (SELECT 'timesheet.write' code, 'TIMESHEET' module, 'feature.timesheet.write' label_key, 1 scopable, 0 sensitive, 0 deprecated FROM dual) s ON (t.code = s.code)
WHEN MATCHED THEN UPDATE SET t.module = s.module, t.label_key = s.label_key, t.scopable = s.scopable, t.sensitive = s.sensitive, t.deprecated = s.deprecated
WHEN NOT MATCHED THEN INSERT (code, module, label_key, scopable, sensitive, deprecated) VALUES (s.code, s.module, s.label_key, s.scopable, s.sensitive, s.deprecated);
MERGE INTO platform.feature t USING (SELECT 'universe.manage' code, 'UNIVERSE' module, 'feature.universe.manage' label_key, 1 scopable, 0 sensitive, 0 deprecated FROM dual) s ON (t.code = s.code)
WHEN MATCHED THEN UPDATE SET t.module = s.module, t.label_key = s.label_key, t.scopable = s.scopable, t.sensitive = s.sensitive, t.deprecated = s.deprecated
WHEN NOT MATCHED THEN INSERT (code, module, label_key, scopable, sensitive, deprecated) VALUES (s.code, s.module, s.label_key, s.scopable, s.sensitive, s.deprecated);
MERGE INTO platform.feature t USING (SELECT 'universe.read' code, 'UNIVERSE' module, 'feature.universe.read' label_key, 1 scopable, 0 sensitive, 0 deprecated FROM dual) s ON (t.code = s.code)
WHEN MATCHED THEN UPDATE SET t.module = s.module, t.label_key = s.label_key, t.scopable = s.scopable, t.sensitive = s.sensitive, t.deprecated = s.deprecated
WHEN NOT MATCHED THEN INSERT (code, module, label_key, scopable, sensitive, deprecated) VALUES (s.code, s.module, s.label_key, s.scopable, s.sensitive, s.deprecated);
MERGE INTO platform.feature t USING (SELECT 'verification.execute' code, 'VERIFICATION' module, 'feature.verification.execute' label_key, 1 scopable, 0 sensitive, 0 deprecated FROM dual) s ON (t.code = s.code)
WHEN MATCHED THEN UPDATE SET t.module = s.module, t.label_key = s.label_key, t.scopable = s.scopable, t.sensitive = s.sensitive, t.deprecated = s.deprecated
WHEN NOT MATCHED THEN INSERT (code, module, label_key, scopable, sensitive, deprecated) VALUES (s.code, s.module, s.label_key, s.scopable, s.sensitive, s.deprecated);
MERGE INTO platform.feature t USING (SELECT 'workpaper.review' code, 'WORKPAPER' module, 'feature.workpaper.review' label_key, 1 scopable, 0 sensitive, 0 deprecated FROM dual) s ON (t.code = s.code)
WHEN MATCHED THEN UPDATE SET t.module = s.module, t.label_key = s.label_key, t.scopable = s.scopable, t.sensitive = s.sensitive, t.deprecated = s.deprecated
WHEN NOT MATCHED THEN INSERT (code, module, label_key, scopable, sensitive, deprecated) VALUES (s.code, s.module, s.label_key, s.scopable, s.sensitive, s.deprecated);
MERGE INTO platform.feature t USING (SELECT 'workpaper.write' code, 'WORKPAPER' module, 'feature.workpaper.write' label_key, 1 scopable, 0 sensitive, 0 deprecated FROM dual) s ON (t.code = s.code)
WHEN MATCHED THEN UPDATE SET t.module = s.module, t.label_key = s.label_key, t.scopable = s.scopable, t.sensitive = s.sensitive, t.deprecated = s.deprecated
WHEN NOT MATCHED THEN INSERT (code, module, label_key, scopable, sensitive, deprecated) VALUES (s.code, s.module, s.label_key, s.scopable, s.sensitive, s.deprecated);

-- Fonctionnalités retirées du registre : marquées dépréciées, jamais supprimées (§2.1.7).
UPDATE platform.feature SET deprecated = 1
 WHERE code NOT IN ('admin.alerts.manage', 'admin.assignment.manage', 'admin.assignment.read', 'admin.authz.simulate', 'admin.cache.evict', 'admin.cache.evict.all', 'admin.cache.read', 'admin.change.approve', 'admin.entity.manage', 'admin.entity.read', 'admin.logs.export', 'admin.logs.level.change', 'admin.logs.security.read', 'admin.logs.tech.read', 'admin.org.manage', 'admin.org.read', 'admin.overview.read', 'admin.position.manage', 'admin.position.read', 'admin.recertification.manage', 'admin.role.manage', 'admin.role.read', 'admin.sod.manage', 'admin.sod.read', 'admin.user.manage', 'admin.user.read', 'auditee.space', 'ccm.control.configure', 'ccm.control.run', 'ccm.exception.convert', 'ccm.exception.triage', 'ccm.population.explore', 'ccm.read', 'ccm.reconciliation.read', 'charter.approve', 'external.finding.manage', 'external.finding.read', 'finding.consolidate', 'finding.read', 'finding.review', 'finding.validate', 'finding.write', 'followup.manage', 'mission.create', 'mission.document.write', 'mission.meeting.write', 'mission.order.approve', 'mission.order.write', 'mission.program.manage', 'mission.read', 'mission.schedule.manage', 'mission.team.manage', 'mission.update', 'ops.ai.manage', 'ops.audittrail.read', 'ops.audittrail.verify', 'ops.config.transfer', 'ops.connector.manage', 'ops.connector.read', 'ops.export.manage', 'ops.health.read', 'ops.import.manage', 'ops.job.manage', 'ops.license.manage', 'ops.pack.manage', 'ops.retention.manage', 'ops.retention.read', 'ops.signature-provider.manage', 'ops.support.approve', 'ops.support.request', 'ops.theme.manage', 'ops.workflow.deploy', 'ops.workflow.operate', 'plan.approve', 'plan.manage', 'plan.read', 'quality.manage', 'quality.read', 'questionnaire.campaign.manage', 'questionnaire.template.manage', 'recommendation.close', 'recommendation.manage', 'recommendation.read', 'report.contradictory.manage', 'report.distribute', 'report.final.approve', 'report.final.generate', 'report.read', 'report.write', 'reporting.committee.manage', 'reporting.dashboard.read', 'reporting.export', 'reporting.regulator.manage', 'request.manage', 'request.read', 'resource.manage', 'resource.read', 'risk.assessment.manage', 'risk.assessment.read', 'settings.charter.manage', 'settings.independence.manage', 'settings.indicator.manage', 'settings.notification.manage', 'settings.publication.approve', 'settings.read', 'settings.referential.manage', 'settings.signature.manage', 'settings.template.manage', 'settings.ui.manage', 'settings.workflow.manage', 'signature.inbox', 'signature.register.read', 'timesheet.approve', 'timesheet.write', 'universe.manage', 'universe.read', 'verification.execute', 'workpaper.review', 'workpaper.write');

#!/bin/bash
#SELECT distinct on (table_name) '#' || table_name ||'
#sqoop import  -Dmapreduce.job.user.classpath.first=true --connect "jdbc:postgresql://$host/edsr" --username "$user" --password "$password" --query "SELECT * FROM omop.'|| table_name ||'  WHERE \$CONDITIONS" --target-dir mimic-omop-avro/'|| table_name ||'/ --split-by '|| column_name ||' --as-avrodatafile --append  -- --schema eds && hadoop jar app/lib/avro-tools-1.8.2.jar getschema mimic-omop-avro/'|| table_name ||'/part-m-00000.avro > '|| table_name ||'.avsc && hdfs dfs -put '|| table_name ||'.avsc mimic-omop-avro/ &&'
#  FROM
#     information_schema.tables
#LEFT JOIN information_schema.columns USING (table_schema, table_name)
#  WHERE
#   tables.table_catalog = 'mimic' AND
#    tables.table_schema = 'omop' 
#AND COLUMNS.data_type = 'integer';


host="$1"
user="$2"
password="$3"
hdfs dfs -rm -r -f mimic-omop-avro && 


#concept_ancestor
 sqoop import -Dmapreduce.job.user.classpath.first=true --connect "jdbc:postgresql://$host/edsr" --username "$user"  --password "$password" --num-mappers 4 --query "SELECT * FROM omop.concept_ancestor WHERE \$CONDITIONS" --target-dir mimic-omop-avro/concept_ancestor/ --split-by ancestor_concept_id --as-avrodatafile --append -- --schema eds && hadoop jar app/lib/avro-tools-1.8.2.jar getschema mimic-omop-avro/concept_ancestor/part-m-00000.avro > concept_ancestor.avsc && hdfs dfs -put concept_ancestor.avsc mimic-omop-avro/
#vocabulary
 sqoop import -Dmapreduce.job.user.classpath.first=true --connect "jdbc:postgresql://$host/edsr" --username "$user" --password "$password" --query "SELECT * FROM omop.vocabulary WHERE \$CONDITIONS" --target-dir mimic-omop-avro/vocabulary/ --split-by vocabulary_concept_id --as-avrodatafile --append -- --schema eds && hadoop jar app/lib/avro-tools-1.8.2.jar getschema mimic-omop-avro/vocabulary/part-m-00000.avro > vocabulary.avsc && hdfs dfs -put vocabulary.avsc mimic-omop-avro/
#domain
 sqoop import -Dmapreduce.job.user.classpath.first=true --connect "jdbc:postgresql://$host/edsr" --username "$user" --password "$password" --query "SELECT * FROM omop.domain WHERE \$CONDITIONS" --target-dir mimic-omop-avro/domain/ --split-by domain_concept_id --as-avrodatafile --append -- --schema eds && hadoop jar app/lib/avro-tools-1.8.2.jar getschema mimic-omop-avro/domain/part-m-00000.avro > domain.avsc && hdfs dfs -put domain.avsc mimic-omop-avro/
 #concept_class +
 sqoop import -Dmapreduce.job.user.classpath.first=true --connect "jdbc:postgresql://$host/edsr" --username "$user" --password "$password" --query "SELECT * FROM omop.concept_class WHERE \$CONDITIONS" --target-dir mimic-omop-avro/concept_class/ --split-by concept_class_concept_id --as-avrodatafile --append -- --schema eds && hadoop jar app/lib/avro-tools-1.8.2.jar getschema mimic-omop-avro/concept_class/part-m-00000.avro > concept_class.avsc && hdfs dfs -put concept_class.avsc mimic-omop-avro/
 #relationship +
 sqoop import -Dmapreduce.job.user.classpath.first=true --connect "jdbc:postgresql://$host/edsr" --username "$user" --password "$password" --query "SELECT * FROM omop.relationship WHERE \$CONDITIONS" --target-dir mimic-omop-avro/relationship/ --split-by relationship_concept_id --as-avrodatafile --append -- --schema eds && hadoop jar app/lib/avro-tools-1.8.2.jar getschema mimic-omop-avro/relationship/part-m-00000.avro > relationship.avsc && hdfs dfs -put relationship.avsc mimic-omop-avro/
 #drug_strength +
 sqoop import -Dmapreduce.job.user.classpath.first=true --connect "jdbc:postgresql://$host/edsr" --username "$user" --password "$password" --query "SELECT * FROM omop.drug_strength WHERE \$CONDITIONS" --target-dir mimic-omop-avro/drug_strength/ --split-by drug_concept_id  --as-avrodatafile --append -- --schema eds && hadoop jar app/lib/avro-tools-1.8.2.jar getschema mimic-omop-avro/drug_strength/part-m-00000.avro > drug_strength.avsc && hdfs dfs -put drug_strength.avsc mimic-omop-avro/
 #concept +
 sqoop import -Dmapreduce.job.user.classpath.first=true --connect "jdbc:postgresql://$host/edsr" --username "$user" --password "$password" --query "SELECT * FROM omop.concept WHERE \$CONDITIONS" --target-dir mimic-omop-avro/concept/ --split-by concept_id --as-avrodatafile --append -- --schema eds && hadoop jar app/lib/avro-tools-1.8.2.jar getschema mimic-omop-avro/concept/part-m-00000.avro > concept.avsc && hdfs dfs -put concept.avsc mimic-omop-avro/
 #concept_synonym +
 sqoop import -Dmapreduce.job.user.classpath.first=true --connect "jdbc:postgresql://$host/edsr" --username "$user" --password "$password" --query "SELECT * FROM omop.concept_synonym WHERE \$CONDITIONS" --target-dir mimic-omop-avro/concept_synonym/ --split-by concept_id --as-avrodatafile --append -- --schema eds && hadoop jar app/lib/avro-tools-1.8.2.jar getschema mimic-omop-avro/concept_synonym/part-m-00000.avro > concept_synonym.avsc && hdfs dfs -put concept_synonym.avsc mimic-omop-avro/
 #concept_relationship +
 sqoop import -Dmapreduce.job.user.classpath.first=true --connect "jdbc:postgresql://$host/edsr" --username "$user" --password "$password" --query "SELECT * FROM omop.concept_relationship WHERE \$CONDITIONS" --target-dir mimic-omop-avro/concept_relationship/ --split-by concept_id_1 --as-avrodatafile --append -- --schema eds && hadoop jar app/lib/avro-tools-1.8.2.jar getschema mimic-omop-avro/concept_relationship/part-m-00000.avro > concept_relationship.avsc && hdfs dfs -put concept_relationship.avsc mimic-omop-avro/

 #care_site +
 sqoop import -Dmapreduce.job.user.classpath.first=true --connect "jdbc:postgresql://$host/edsr" --username "$user" --password "$password" --query "SELECT * FROM omop.care_site WHERE \$CONDITIONS" --target-dir mimic-omop-avro/care_site/ --split-by location_id --as-avrodatafile --append -- --schema eds && hadoop jar app/lib/avro-tools-1.8.2.jar getschema mimic-omop-avro/care_site/part-m-00000.avro > care_site.avsc && hdfs dfs -put care_site.avsc mimic-omop-avro/ &&
 #cohort +
 sqoop import -Dmapreduce.job.user.classpath.first=true --connect "jdbc:postgresql://$host/edsr" --username "$user" --password "$password" --query "SELECT * FROM omop.cohort WHERE \$CONDITIONS" --target-dir mimic-omop-avro/cohort/ --split-by subject_id --as-avrodatafile --append -- --schema eds && hadoop jar app/lib/avro-tools-1.8.2.jar getschema mimic-omop-avro/cohort/part-m-00000.avro > cohort.avsc && hdfs dfs -put cohort.avsc mimic-omop-avro/ &&
 #cohort_definition +
 sqoop import -Dmapreduce.job.user.classpath.first=true --connect "jdbc:postgresql://$host/edsr" --username "$user" --password "$password" --query "SELECT * FROM omop.cohort_definition WHERE \$CONDITIONS" --target-dir mimic-omop-avro/cohort_definition/ --split-by cohort_definition_id --as-avrodatafile --append -- --schema eds && hadoop jar app/lib/avro-tools-1.8.2.jar getschema mimic-omop-avro/cohort_definition/part-m-00000.avro > cohort_definition.avsc && hdfs dfs -put cohort_definition.avsc mimic-omop-avro/ &&
 #attribute_definition +
 sqoop import -Dmapreduce.job.user.classpath.first=true --connect "jdbc:postgresql://$host/edsr" --username "$user" --password "$password" --query "SELECT * FROM omop.attribute_definition WHERE \$CONDITIONS" --target-dir mimic-omop-avro/attribute_definition/ --split-by attribute_definition_id --as-avrodatafile --append -- --schema eds && hadoop jar app/lib/avro-tools-1.8.2.jar getschema mimic-omop-avro/attribute_definition/part-m-00000.avro > attribute_definition.avsc && hdfs dfs -put attribute_definition.avsc mimic-omop-avro/ &&
 #cohort_attribute +
 sqoop import -Dmapreduce.job.user.classpath.first=true --connect "jdbc:postgresql://$host/edsr" --username "$user" --password "$password" --query "SELECT * FROM omop.cohort_attribute WHERE \$CONDITIONS" --target-dir mimic-omop-avro/cohort_attribute/ --split-by cohort_definition_id --as-avrodatafile --append -- --schema eds && hadoop jar app/lib/avro-tools-1.8.2.jar getschema mimic-omop-avro/cohort_attribute/part-m-00000.avro > cohort_attribute.avsc && hdfs dfs -put cohort_attribute.avsc mimic-omop-avro/ &&
 #condition_era +
# sqoop import -Dmapreduce.job.user.classpath.first=true --connect "jdbc:postgresql://$host/edsr" --username "$user" --password "$password" --query "SELECT * FROM omop.condition_era WHERE \$CONDITIONS" --target-dir mimic-omop-avro/condition_era/ --split-by condition_occurrence_count --as-avrodatafile --append -- --schema eds && hadoop jar app/lib/avro-tools-1.8.2.jar getschema mimic-omop-avro/condition_era/part-m-00000.avro > condition_era.avsc && hdfs dfs -put condition_era.avsc mimic-omop-avro/ &&
 #condition_occurrence +
 sqoop import -Dmapreduce.job.user.classpath.first=true --connect "jdbc:postgresql://$host/edsr" --username "$user" --password "$password" --query "SELECT * FROM omop.condition_occurrence WHERE \$CONDITIONS" --target-dir mimic-omop-avro/condition_occurrence/ --split-by condition_occurrence_id --as-avrodatafile --append -- --schema eds && hadoop jar app/lib/avro-tools-1.8.2.jar getschema mimic-omop-avro/condition_occurrence/part-m-00000.avro > condition_occurrence.avsc && hdfs dfs -put condition_occurrence.avsc mimic-omop-avro/ &&
 #cost +
 #sqoop import -Dmapreduce.job.user.classpath.first=true --connect "jdbc:postgresql://$host/edsr" --username "$user" --password "$password" --query "SELECT * FROM omop.cost WHERE \$CONDITIONS" --target-dir mimic-omop-avro/cost/ --split-by payer_plan_period_id --as-avrodatafile --append -- --schema eds && hadoop jar app/lib/avro-tools-1.8.2.jar getschema mimic-omop-avro/cost/part-m-00000.avro > cost.avsc && hdfs dfs -put cost.avsc mimic-omop-avro/ &&
 #death +
 sqoop import -Dmapreduce.job.user.classpath.first=true --connect "jdbc:postgresql://$host/edsr" --username "$user" --password "$password" --query "SELECT * FROM omop.death WHERE \$CONDITIONS" --target-dir mimic-omop-avro/death/ --split-by cause_concept_id --as-avrodatafile --append -- --schema eds && hadoop jar app/lib/avro-tools-1.8.2.jar getschema mimic-omop-avro/death/part-m-00000.avro > death.avsc && hdfs dfs -put death.avsc mimic-omop-avro/ &&
 #device_exposure +
 #sqoop import -Dmapreduce.job.user.classpath.first=true --connect "jdbc:postgresql://$host/edsr" --username "$user" --password "$password" --query "SELECT * FROM omop.device_exposure WHERE \$CONDITIONS" --target-dir mimic-omop-avro/device_exposure/ --split-by device_exposure_id --as-avrodatafile --append -- --schema eds && hadoop jar app/lib/avro-tools-1.8.2.jar getschema mimic-omop-avro/device_exposure/part-m-00000.avro > device_exposure.avsc && hdfs dfs -put device_exposure.avsc mimic-omop-avro/ &&
 #dose_era +
# sqoop import -Dmapreduce.job.user.classpath.first=true --connect "jdbc:postgresql://$host/edsr" --username "$user" --password "$password" --query "SELECT * FROM omop.dose_era WHERE \$CONDITIONS" --target-dir mimic-omop-avro/dose_era/ --split-by drug_concept_id --as-avrodatafile --append -- --schema eds && hadoop jar app/lib/avro-tools-1.8.2.jar getschema mimic-omop-avro/dose_era/part-m-00000.avro > dose_era.avsc && hdfs dfs -put dose_era.avsc mimic-omop-avro/ &&
 #drug_era +
# sqoop import -Dmapreduce.job.user.classpath.first=true --connect "jdbc:postgresql://$host/edsr" --username "$user" --password "$password" --query "SELECT * FROM omop.drug_era WHERE \$CONDITIONS" --target-dir mimic-omop-avro/drug_era/ --split-by drug_concept_id --as-avrodatafile --append -- --schema eds && hadoop jar app/lib/avro-tools-1.8.2.jar getschema mimic-omop-avro/drug_era/part-m-00000.avro > drug_era.avsc && hdfs dfs -put drug_era.avsc mimic-omop-avro/ &&
 #drug_exposure +
 sqoop import -Dmapreduce.job.user.classpath.first=true --connect "jdbc:postgresql://$host/edsr" --username "$user" --password "$password" --num-mappers 4 --query "SELECT * FROM omop.drug_exposure WHERE \$CONDITIONS" --target-dir mimic-omop-avro/drug_exposure/ --split-by refills --as-avrodatafile --append -- --schema eds && hadoop jar app/lib/avro-tools-1.8.2.jar getschema mimic-omop-avro/drug_exposure/part-m-00000.avro > drug_exposure.avsc && hdfs dfs -put drug_exposure.avsc mimic-omop-avro/ &&
 #fact_relationship +
 sqoop import -Dmapreduce.job.user.classpath.first=true --connect "jdbc:postgresql://$host/edsr" --username "$user" --password "$password" --num-mappers 4 --query "SELECT * FROM omop.fact_relationship WHERE \$CONDITIONS" --target-dir mimic-omop-avro/fact_relationship/ --split-by domain_concept_id_1 --as-avrodatafile --append -- --schema eds && hadoop jar app/lib/avro-tools-1.8.2.jar getschema mimic-omop-avro/fact_relationship/part-m-00000.avro > fact_relationship.avsc && hdfs dfs -put fact_relationship.avsc mimic-omop-avro/ &&
 #measurement +
 sqoop import -Dmapreduce.job.user.classpath.first=true --connect "jdbc:postgresql://$host/edsr" --username "$user" --password "$password" --num-mappers 6 --query "SELECT * FROM omop.measurement WHERE \$CONDITIONS" --target-dir mimic-omop-avro/measurement/ --split-by measurement_id --as-avrodatafile --append -- --schema eds && hadoop jar app/lib/avro-tools-1.8.2.jar getschema mimic-omop-avro/measurement/part-m-00000.avro > measurement.avsc && hdfs dfs -put measurement.avsc mimic-omop-avro/ &&
 #note +
 sqoop import -Dmapreduce.job.user.classpath.first=true --connect "jdbc:postgresql://$host/edsr" --username "$user" --password "$password" --query "SELECT * FROM omop.note WHERE \$CONDITIONS" --target-dir mimic-omop-avro/note/ --split-by person_id --as-avrodatafile --append -- --schema eds && hadoop jar app/lib/avro-tools-1.8.2.jar getschema mimic-omop-avro/note/part-m-00000.avro > note.avsc && hdfs dfs -put note.avsc mimic-omop-avro/ &&
 #observation +
 sqoop import -Dmapreduce.job.user.classpath.first=true --connect "jdbc:postgresql://$host/edsr" --username "$user" --password "$password" --num-mappers 4 --query "SELECT * FROM omop.observation WHERE \$CONDITIONS" --target-dir mimic-omop-avro/observation/ --split-by observation_id --as-avrodatafile --append -- --schema eds && hadoop jar app/lib/avro-tools-1.8.2.jar getschema mimic-omop-avro/observation/part-m-00000.avro > observation.avsc && hdfs dfs -put observation.avsc mimic-omop-avro/ &&
 #observation_period +
 sqoop import -Dmapreduce.job.user.classpath.first=true --connect "jdbc:postgresql://$host/edsr" --username "$user" --password "$password" --query "SELECT * FROM omop.observation_period WHERE \$CONDITIONS" --target-dir mimic-omop-avro/observation_period/ --split-by observation_period_id --as-avrodatafile --append -- --schema eds && hadoop jar app/lib/avro-tools-1.8.2.jar getschema mimic-omop-avro/observation_period/part-m-00000.avro > observation_period.avsc && hdfs dfs -put observation_period.avsc mimic-omop-avro/ &&
 #payer_plan_period +
# sqoop import -Dmapreduce.job.user.classpath.first=true --connect "jdbc:postgresql://$host/edsr" --username "$user" --password "$password" --query "SELECT * FROM omop.payer_plan_period WHERE \$CONDITIONS" --target-dir mimic-omop-avro/payer_plan_period/ --split-by person_id --as-avrodatafile --append -- --schema eds && hadoop jar app/lib/avro-tools-1.8.2.jar getschema mimic-omop-avro/payer_plan_period/part-m-00000.avro > payer_plan_period.avsc && hdfs dfs -put payer_plan_period.avsc mimic-omop-avro/ &&
 #person +
 sqoop import -Dmapreduce.job.user.classpath.first=true --connect "jdbc:postgresql://$host/edsr" --username "$user" --password "$password" --query "SELECT * FROM omop.person WHERE \$CONDITIONS" --target-dir mimic-omop-avro/person/ --split-by month_of_birth --as-avrodatafile --append -- --schema eds && hadoop jar app/lib/avro-tools-1.8.2.jar getschema mimic-omop-avro/person/part-m-00000.avro > person.avsc && hdfs dfs -put person.avsc mimic-omop-avro/ &&
 #procedure_occurrence +
 sqoop import -Dmapreduce.job.user.classpath.first=true --connect "jdbc:postgresql://$host/edsr" --username "$user" --password "$password" --query "SELECT * FROM omop.procedure_occurrence WHERE \$CONDITIONS" --target-dir mimic-omop-avro/procedure_occurrence/ --split-by procedure_source_concept_id --as-avrodatafile --append -- --schema eds && hadoop jar app/lib/avro-tools-1.8.2.jar getschema mimic-omop-avro/procedure_occurrence/part-m-00000.avro > procedure_occurrence.avsc && hdfs dfs -put procedure_occurrence.avsc mimic-omop-avro/ &&
 #provider +
 sqoop import -Dmapreduce.job.user.classpath.first=true --connect "jdbc:postgresql://$host/edsr" --username "$user" --password "$password" --query "SELECT * FROM omop.provider WHERE \$CONDITIONS" --target-dir mimic-omop-avro/provider/ --split-by year_of_birth --as-avrodatafile --append -- --schema eds && hadoop jar app/lib/avro-tools-1.8.2.jar getschema mimic-omop-avro/provider/part-m-00000.avro > provider.avsc && hdfs dfs -put provider.avsc mimic-omop-avro/ &&
 #specimen +
 sqoop import -Dmapreduce.job.user.classpath.first=true --connect "jdbc:postgresql://$host/edsr" --username "$user" --password "$password" --query "SELECT * FROM omop.specimen WHERE \$CONDITIONS" --target-dir mimic-omop-avro/specimen/ --split-by specimen_id --as-avrodatafile --append -- --schema eds && hadoop jar app/lib/avro-tools-1.8.2.jar getschema mimic-omop-avro/specimen/part-m-00000.avro > specimen.avsc && hdfs dfs -put specimen.avsc mimic-omop-avro/ &&
 #visit_detail +
 sqoop import -Dmapreduce.job.user.classpath.first=true --connect "jdbc:postgresql://$host/edsr" --username "$user" --password "$password" --query "SELECT * FROM omop.visit_detail WHERE \$CONDITIONS" --target-dir mimic-omop-avro/visit_detail/ --split-by visit_detail_id --as-avrodatafile --append -- --schema eds && hadoop jar app/lib/avro-tools-1.8.2.jar getschema mimic-omop-avro/visit_detail/part-m-00000.avro > visit_detail.avsc && hdfs dfs -put visit_detail.avsc mimic-omop-avro/ &&
 #visit_occurrence +
 sqoop import -Dmapreduce.job.user.classpath.first=true --connect "jdbc:postgresql://$host/edsr" --username "$user" --password "$password" --query "SELECT * FROM omop.visit_occurrence WHERE \$CONDITIONS" --target-dir mimic-omop-avro/visit_occurrence/ --split-by visit_occurrence_id --as-avrodatafile --append -- --schema eds && hadoop jar app/lib/avro-tools-1.8.2.jar getschema mimic-omop-avro/visit_occurrence/part-m-00000.avro > visit_occurrence.avsc && hdfs dfs -put visit_occurrence.avsc mimic-omop-avro/ &&
 #note_nlp +
 sqoop import -Dmapreduce.job.user.classpath.first=true --connect "jdbc:postgresql://$host/edsr" --username "$user" --password "$password" --query "SELECT * FROM omop.note_nlp WHERE \$CONDITIONS" --target-dir mimic-omop-avro/note_nlp/ --split-by note_id --as-avrodatafile --append -- --schema eds && hadoop jar app/lib/avro-tools-1.8.2.jar getschema mimic-omop-avro/note_nlp/part-m-00000.avro > note_nlp.avsc && hdfs dfs -put note_nlp.avsc mimic-omop-avro/ 

Alias: $SCT = http://snomed.info/sct
Alias: $UCUM = http://unitsofmeasure.org
Alias: $ObsCat = http://terminology.hl7.org/CodeSystem/observation-category
Alias: $analyte-archetype = https://specifications.openehr.org/releases/CKM/latest/CLUSTER.laboratory_test_analyte.v1

Profile: LabResult
Parent: Observation
Id: LabResult
Title: "Laboratory Analyte Result"
Description: """
FHIR Observation profile representing a single laboratory analyte result.

Designed to be semantically interoperable with the openEHR
`openEHR-EHR-CLUSTER.laboratory_test_analyte.v1` archetype. Every constrained
element below carries an explicit `mapping` entry pointing at the equivalent
archetype node path. Four archetype elements have no idiomatic FHIR equivalent
on Observation and are documented as additional mapping rows (with
"(not represented)"): `at0027` (Analyte result sequence), `at0014` (Analyte
result detail), `at0006` (Result status time), `at0032` (Accredited).
"""

* ^mapping[+].identity = "openehr-analyte"
* ^mapping[=].uri = $analyte-archetype
* ^mapping[=].name = "openEHR Laboratory analyte result (v1)"
* ^mapping[=].comment = "Element-by-element mapping to openEHR-EHR-CLUSTER.laboratory_test_analyte.v1. Paths are relative to the archetype root CLUSTER[at0000]."

// Archetype elements not represented on Observation itself; documented here for completeness.
* . ^mapping[+].identity = "openehr-analyte"
* . ^mapping[=].map = "items[at0027]/value (not represented)"
* . ^mapping[=].comment = "openEHR 'Analyte result sequence' (DV_COUNT) records the position of this analyte within a multi-analyte report (e.g. HL7 v2 OBX-1). When a panel is represented as multiple FHIR Observation resources, ordering is conveyed by the position in DiagnosticReport.result rather than on the Observation itself. Add an extension if you need to preserve the integer on the individual resource."
* . ^mapping[+].identity = "openehr-analyte"
* . ^mapping[=].map = "items[at0014] (not represented)"
* . ^mapping[=].comment = "openEHR 'Analyte result detail' is an open CLUSTER slot used to plug in additional structured detail (e.g. quality flags, microbiology susceptibility, derived calculations). FHIR-side this would land in Observation.component for sub-measurements, Observation.hasMember / derivedFrom for related Observations, or an extension for ad-hoc data."

* category 1..* MS
* category ^slicing.discriminator.type = #pattern
* category ^slicing.discriminator.path = "$this"
* category ^slicing.rules = #open
* category contains laboratory 1..1 MS
* category[laboratory] = $ObsCat#laboratory "Laboratory"
* category ^mapping[+].identity = "openehr-analyte"
* category ^mapping[=].map = "(implicit)"
* category ^mapping[=].comment = "No equivalent element on the openEHR archetype — the laboratory context is implicit in the archetype's identity (openEHR-EHR-CLUSTER.laboratory_test_analyte). FHIR makes this explicit on Observation.category and we therefore fix it to 'laboratory'."

* status 1..1 MS
* status ^mapping[+].identity = "openehr-analyte"
* status ^mapping[=].map = "items[at0005]/value"
* status ^mapping[=].comment = "openEHR DV_CODED_TEXT (registered|partial|preliminary|final|corrected|amended|appended|entered-in-error|cancelled) → FHIR Observation.status. 'partial' and 'appended' have no exact FHIR code and collapse to 'preliminary' and 'amended' respectively."
* status ^mapping[+].identity = "openehr-analyte"
* status ^mapping[=].map = "items[at0006]/value (not represented)"
* status ^mapping[=].comment = "openEHR 'Result status time' records *when* the status above transitioned to its current value. FHIR Observation has no analogous timestamp field — the audit trail of status changes is normally carried on a Provenance resource pointing at the Observation, with Provenance.recorded holding this value."

* code 1..1 MS
* code ^mapping[+].identity = "openehr-analyte"
* code ^mapping[=].map = "items[at0024]/value"
* code ^mapping[=].comment = "openEHR DV_TEXT (Analyte name) → FHIR Observation.code (CodeableConcept). FHIR encourages a coded value (LOINC or SNOMED CT); the archetype permits free text."

* value[x] MS
* value[x] ^mapping[+].identity = "openehr-analyte"
* value[x] ^mapping[=].map = "items[at0001]/value"
* value[x] ^mapping[=].comment = "openEHR 'Analyte result' is type-open (DV_QUANTITY, DV_CODED_TEXT, DV_TEXT, DV_BOOLEAN, DV_ORDINAL, …). FHIR value[x] expresses the same flexibility via its multiple alternative types."

* effectiveDateTime 0..1 MS
* effectiveDateTime ^mapping[+].identity = "openehr-analyte"
* effectiveDateTime ^mapping[=].map = "items[at0031]/value"
* effectiveDateTime ^mapping[=].comment = "openEHR 'Analysis performed time' (DV_DATE_TIME) → FHIR Observation.effective[x]: when the analysis was physically performed."

* issued 0..1 MS
* issued ^mapping[+].identity = "openehr-analyte"
* issued ^mapping[=].map = "items[at0025]/value"
* issued ^mapping[=].comment = "openEHR 'Validation time' (DV_DATE_TIME) → FHIR Observation.issued: when the validated result was released."

* method 0..1
* method ^mapping[+].identity = "openehr-analyte"
* method ^mapping[=].map = "items[at0028]/value"
* method ^mapping[=].comment = "openEHR 'Test method' → FHIR Observation.method (CodeableConcept)."
* method ^mapping[+].identity = "openehr-analyte"
* method ^mapping[=].map = "items[at0032]/value (not represented)"
* method ^mapping[=].comment = "openEHR 'Accredited' (DV_BOOLEAN / DV_TEXT) flags whether the analytical method holds an accreditation (e.g. ISO 15189). FHIR Observation has no native field for this quality-assurance flag; would need an extension on Observation.method if required."

* specimen 0..1
* specimen ^mapping[+].identity = "openehr-analyte"
* specimen ^mapping[=].map = "items[at0026]/value"
* specimen ^mapping[=].comment = "openEHR 'Specimen' (DV_IDENTIFIER / DV_URI / DV_TEXT) → FHIR Observation.specimen (Reference to Specimen). FHIR moves identification into a separate Specimen resource."

* referenceRange 0..*
* referenceRange ^mapping[+].identity = "openehr-analyte"
* referenceRange ^mapping[=].map = "items[at0004]/value"
* referenceRange ^mapping[=].comment = "openEHR 'Reference range guidance' (DV_TEXT) lands in Observation.referenceRange.text. Numeric low/high typically come from the result DV_QUANTITY's normalRange, which is not modelled at this archetype level."

* note 0..*
* note ^mapping[+].identity = "openehr-analyte"
* note ^mapping[=].map = "items[at0003]/value"
* note ^mapping[=].comment = "openEHR 'Comment' (DV_TEXT, 0..*) → FHIR Observation.note (Annotation, 0..*). The DV_TEXT value lands in Annotation.text."


Instance: example-psa-result
InstanceOf: LabResult
Usage: #example
Title: "Example PSA Result (4.2 ng/mL)"
Description: "Sample LabResult instance demonstrating archetype-compatible population of every mapped element."
* status = #final
* category[laboratory] = $ObsCat#laboratory "Laboratory"
* code = $SCT#63476009 "Prostate specific antigen measurement"
* effectiveDateTime = "2026-05-16T08:23:00+02:00"
* issued = "2026-05-16T11:05:00+02:00"
* valueQuantity = 4.2 $UCUM#ng/mL "ng/mL"
* method = $SCT#726449005 "Immunoassay technique"
* referenceRange.text = "<4.0 ng/mL for males over 50"
* note.text = "Sample slightly haemolysed; result interpreted with caution."

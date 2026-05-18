Alias: $SCT = http://snomed.info/sct
Alias: $LOINC = http://loinc.org
Alias: $UCUM = http://unitsofmeasure.org
Alias: $ObsCat = http://terminology.hl7.org/CodeSystem/observation-category
Alias: $openehr-imaging-exam-result = https://ckm.openehr.org/ckm/archetypes/1013.1.1494
Alias: $openehr-imaging-exam = https://ckm.openehr.org/ckm/archetypes/1013.1.5915

Profile: ImagingMeasurement
Parent: Observation
Id: ImagingMeasurement
Title: "Imaging Measurement"
Description: """
FHIR Observation profile representing a single dimensional measurement
(diameter, length, area, volume, circumference, angle, thickness, …) of an
anatomical structure or lesion derived from an imaging study.

Typical use cases include tumor diameter on CT (RECIST), aortic annulus
diameter on cardiac MRI (pre-TAVR sizing), and prostate volume on TRUS.
The `category` slice is fixed to `imaging`, locking the profile to
image-derived measurements; non-imaging measurements of the same structures
(e.g. DRE-estimated prostate volume, physical-exam head circumference)
belong on a sibling profile.

### openEHR alignment

This profile is mapped against two openEHR archetypes because openEHR
aggregates imaging data differently than FHIR:

* `openEHR-EHR-OBSERVATION.imaging_exam_result.v1` — report-level
  archetype (analogous to FHIR `DiagnosticReport`). Carries study-wide
  context: modality, study date, status, source image references.
* `openEHR-EHR-CLUSTER.imaging_exam.v1` — per-body-structure findings
  archetype, plus its specialisations (e.g. `imaging_exam-lymph_node.v0`)
  which add structure-specific quantitative ELEMENTs such as `at0.2`
  Diameter (DV_QUANTITY, mm, up to 3 occurrences for 3 axes).

**Inverted aggregation:** openEHR nests measurements under a body-structure
cluster under a report; FHIR (this profile) keeps one Observation per
measurement and uses `bodySite`/`focus` to record the structure. The two
forms are semantically equivalent — `component` here corresponds to the
multi-occurrence ELEMENT pattern in the openEHR specialisations
(e.g. three Diameter occurrences for three axes).

The actual measurement quantity has no node in the base
`CLUSTER.imaging_exam.v1` — it lives in body-structure specialisations
(`imaging_exam-lymph_node.v0/items[at0.2]`, …) — so `value[x]` maps to
the specialisation node, not the base archetype.
"""

* ^mapping[+].identity = "openehr-imaging-exam-result"
* ^mapping[=].uri = $openehr-imaging-exam-result
* ^mapping[=].name = "openEHR Imaging examination result (v1)"
* ^mapping[=].comment = "Report-level archetype. Provides study-wide context (modality, study date, status, image URI) that FHIR repeats on each ImagingMeasurement or carries on a parent DiagnosticReport. Paths are relative to OBSERVATION[at0000]."

* ^mapping[+].identity = "openehr-imaging-exam"
* ^mapping[=].uri = $openehr-imaging-exam
* ^mapping[=].name = "openEHR Imaging examination of a body structure (CLUSTER, v1)"
* ^mapping[=].comment = "Per-body-structure findings archetype. Provides body site/structure context and is the parent of measurement-bearing specialisations (imaging_exam-lymph_node.v0, etc.). Paths are relative to CLUSTER[at0000]."

* category 1..* MS
* category ^slicing.discriminator.type = #pattern
* category ^slicing.discriminator.path = "$this"
* category ^slicing.rules = #open
* category contains imaging 1..1 MS
* category[imaging] = $ObsCat#imaging "Imaging"
* category ^mapping[+].identity = "openehr-imaging-exam-result"
* category ^mapping[=].map = "(implicit)"
* category ^mapping[=].comment = "No equivalent on the openEHR side — the imaging context is implicit in the archetype identity. FHIR makes it explicit and we fix it to 'imaging'."

* status 1..1 MS
* status ^mapping[+].identity = "openehr-imaging-exam-result"
* status ^mapping[=].map = "data/events/data/items[at0072]/value"
* status ^mapping[=].comment = "openEHR 'Overall result status' (DV_CODED_TEXT: registered|partial|preliminary|final|amended|corrected|appended|cancelled|unknown) → FHIR Observation.status. 'partial' / 'appended' have no exact FHIR code and collapse to 'preliminary' / 'amended' respectively. openEHR carries this at report level — FHIR repeats it on each Observation."
* status ^mapping[+].identity = "openehr-imaging-exam-result"
* status ^mapping[=].map = "data/events/data/items[at0071]/value (not represented)"
* status ^mapping[=].comment = "openEHR 'Status timestamp' has no analogous field on Observation — the audit trail of status changes is normally carried on a Provenance resource pointing at the Observation, with Provenance.recorded holding this value."

* code 1..1 MS
* code ^short = "Kind of measurement (diameter, volume, area, length, circumference, angle, thickness, …)"
* code ^mapping[+].identity = "openehr-imaging-exam"
* code ^mapping[=].map = "(archetype node identity)"
* code ^mapping[=].comment = "openEHR encodes the kind of measurement in the at-code of the ELEMENT node within a specialisation (e.g. items[at0.2] 'Diameter' on imaging_exam-lymph_node.v0). FHIR makes the measurement kind explicit on Observation.code (CodeableConcept), bound to a measurement-property value set."

* value[x] 1..1 MS
* value[x] only Quantity
* valueQuantity.system = $UCUM (exactly)
* value[x] ^mapping[+].identity = "openehr-imaging-exam"
* value[x] ^mapping[=].map = "items[at0.N]/value  (on a specialisation, e.g. imaging_exam-lymph_node.v0/items[at0.2])"
* value[x] ^mapping[=].comment = "openEHR DV_QUANTITY on a structure-specific specialisation ELEMENT → FHIR Observation.valueQuantity. The base CLUSTER.imaging_exam.v1 has no native measurement node; the quantity always lives on a specialisation."

* bodySite 0..1 MS
* bodySite ^short = "Anatomical site of the measured structure"
* bodySite ^mapping[+].identity = "openehr-imaging-exam"
* bodySite ^mapping[=].map = "items[at0001]/value  +  items[at0002]/value"
* bodySite ^mapping[=].comment = "openEHR splits anatomy across 'Body structure' (at0001, DV_TEXT, the organ/structure) and 'Body site' (at0002, DV_TEXT, the area). FHIR collapses both into Observation.bodySite (CodeableConcept). Coding with SNOMED CT is recommended on both sides."

* focus 0..* MS
* focus ^short = "The tracked lesion or structure being measured (e.g. a BodyStructure for longitudinal RECIST tracking)"
* focus ^mapping[+].identity = "openehr-imaging-exam"
* focus ^mapping[=].map = "items[at0003]  (Structured body site → CLUSTER.anatomical_location.v1 / .anatomical_location_relative.v2 / .anatomical_location_circle.v1)"
* focus ^mapping[=].comment = "openEHR uses a CLUSTER slot for structured anatomy (relative location, circle, etc.). FHIR points Observation.focus at a BodyStructure resource for the same purpose — and uses focus rather than bodySite for tracked-over-time lesions."

* method 0..1 MS
* method ^short = "Imaging modality or measurement technique (CT, MRI, US, PET, …)"
* method ^mapping[+].identity = "openehr-imaging-exam-result"
* method ^mapping[=].map = "data/events/data/items[at0091]/value"
* method ^mapping[=].comment = "openEHR 'Modality' (DV_TEXT, at report level) → FHIR Observation.method (CodeableConcept). openEHR also has a 'Technique' element on protocol/items[at0087] for finer detail; that lands on Observation.method as well or is moved to ImagingStudy.series.modality if referenced."

* derivedFrom 0..* MS
* derivedFrom only Reference(ImagingStudy or DocumentReference or Media or DiagnosticReport)
* derivedFrom ^short = "Source image, study or report the measurement was taken from"
* derivedFrom ^mapping[+].identity = "openehr-imaging-exam-result"
* derivedFrom ^mapping[=].map = "protocol/items[at0106]/value  (Image details, DV_URI, 0..*)  +  protocol/items[at0092] (Study instance identifier)"
* derivedFrom ^mapping[=].comment = "openEHR holds image URIs on the protocol section and a separate Study instance identifier element. FHIR references the whole ImagingStudy / Media / DocumentReference resource instead, where the URIs and identifiers live."

* effective[x] 0..1 MS
* effective[x] only dateTime or Period
* effective[x] ^short = "Image acquisition time (not interpretation time)"
* effective[x] ^mapping[+].identity = "openehr-imaging-exam-result"
* effective[x] ^mapping[=].map = "data/events/data/items[at0070]/value"
* effective[x] ^mapping[=].comment = "openEHR 'Study date' (DV_DATE_TIME) → FHIR Observation.effective[x]. Both denote when the image was acquired, not when it was interpreted."

* component 0..*
* component ^short = "Paired measurements captured on the same acquisition (e.g. RECIST long + short axis of one lesion)"
* component.code 1..1 MS
* component.value[x] 1..1 MS
* component.value[x] only Quantity
* component ^mapping[+].identity = "openehr-imaging-exam"
* component ^mapping[=].map = "items[at0.N] (multiple occurrences on the same specialisation, e.g. imaging_exam-lymph_node.v0/items[at0.2] occurrences 0..3 for three axes)"
* component ^mapping[=].comment = "openEHR allows the same measurement ELEMENT to occur multiple times on a structure-specific cluster (e.g. Diameter 0..3 on lymph_node, one per axis). FHIR captures sibling axes as component entries on the same Observation, with each component.code naming the axis."


Instance: example-tumor-long-axis-ct
InstanceOf: ImagingMeasurement
Usage: #example
Title: "Example: RECIST target lesion long-axis on CT (32 mm)"
Description: "Long-axis diameter of a hepatic target lesion measured on a contrast-enhanced CT, per RECIST 1.1."
* status = #final
* category[imaging] = $ObsCat#imaging "Imaging"
* code = $SCT#81827009 "Diameter"
* valueQuantity = 32 $UCUM#mm "mm"
* bodySite = $SCT#10200004 "Liver"
* method = $SCT#77477000 "Computed tomography"
* effectiveDateTime = "2026-04-12T09:14:00+02:00"


Instance: example-aortic-annulus-diameter-mri
InstanceOf: ImagingMeasurement
Usage: #example
Title: "Example: Aortic annulus diameter on cardiac MRI (24 mm)"
Description: "Aortic annulus mean diameter measured on cardiac MRI for pre-TAVR sizing, with long and short axes captured as components."
* status = #final
* category[imaging] = $ObsCat#imaging "Imaging"
* code = $SCT#81827009 "Diameter"
* valueQuantity = 24 $UCUM#mm "mm"
* bodySite = $SCT#77583004 "Anulus fibrosus of aorta"
* method = $SCT#113091000 "Magnetic resonance imaging"
* effectiveDateTime = "2026-05-02T10:30:00+02:00"
* component[0].code = $SCT#439933003 "Long axis length of structure by imaging measurement"
* component[=].valueQuantity = 25.4 $UCUM#mm "mm"
* component[+].code = $SCT#439428006 "Short axis length of structure by imaging measurement"
* component[=].valueQuantity = 22.6 $UCUM#mm "mm"


Instance: example-prostate-volume-trus
InstanceOf: ImagingMeasurement
Usage: #example
Title: "Example: Prostate volume on TRUS (42 mL)"
Description: "Prostate volume estimated from transrectal ultrasound using the ellipsoid formula."
* status = #final
* category[imaging] = $ObsCat#imaging "Imaging"
* code = $SCT#118565006 "Volume"
* valueQuantity = 42 $UCUM#mL "mL"
* bodySite = $SCT#41216001 "Prostate"
* method = $SCT#446045006 "Ultrasonography by transrectal approach"
* effectiveDateTime = "2026-05-10T14:05:00+02:00"

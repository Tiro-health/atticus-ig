Alias: $SCT = http://snomed.info/sct
Alias: $LOINC = http://loinc.org
Alias: $UCUM = http://unitsofmeasure.org
Alias: $ObsCat = http://terminology.hl7.org/CodeSystem/observation-category

CodeSystem: TiroCardiacMetric
Id: tiro-cardiac-metric
Title: "Tiro Cardiac Metric Codes"
Description: """
Local codes for cardiac monitoring metrics that have no equivalent in LOINC
or SNOMED CT. Used as panel grouper codes on parent `Observation.code` and
for component codes that LOINC does not currently define (atrial fibrillation
burden, episode counts, longest-episode durations, ventricular and
supraventricular ectopy counts, run lengths, …).

These codes are a stopgap. Each entry should be replaced with a LOINC or
SNOMED CT code as soon as a suitable concept becomes available.
"""
* ^url = "http://fhir.tiro.health/CodeSystem/tiro-cardiac-metric"
* ^content = #complete
* ^experimental = false
* ^caseSensitive = true

// Panel grouper codes (used on parent Observation.code)
* #afib-panel "Atrial fibrillation Holter panel"
* #pause-panel "Sinus pause Holter panel"
* #ventricular-ectopy-panel "Ventricular ectopy Holter panel"
* #supraventricular-ectopy-panel "Supraventricular ectopy Holter panel"
* #heart-rate-24h-panel "Heart rate 24h Holter panel"

// AFib component metrics
* #afib-burden "Atrial fibrillation burden (% of recording in AF)"
* #afib-episode-count "Atrial fibrillation episode count"
* #afib-longest-episode "Atrial fibrillation longest episode duration"

// Sinus pause component metrics
* #pause-count "Sinus pause count"
* #longest-pause "Longest sinus pause duration"

// Ventricular ectopy component metrics
* #pvc-count "Premature ventricular contraction count"
* #vt-run-count "Ventricular tachycardia run count"
* #vt-longest-run "Ventricular tachycardia longest run length"

// Supraventricular ectopy component metrics
* #sveb-count "Supraventricular ectopic beat count"
* #svt-run-count "Supraventricular tachycardia run count"
* #svt-longest-run "Supraventricular tachycardia longest run length"


Profile: CardiacMeasurement
Parent: Observation
Id: CardiacMeasurement
Title: "Cardiac Measurement"
Description: """
FHIR Observation profile for measurements and findings derived from a
cardiac diagnostic procedure such as a resting 12-lead ECG or an
ambulatory (Holter) recording.

Examples include resting heart rate, the standard ECG intervals
(PR, QRS, QT, QTc Bazett / Fridericia, P duration), the cardiologist's
overall ECG impression, and Holter-derived summaries (24h heart rate
min/avg/max, atrial fibrillation burden and episode statistics, sinus
pauses, ventricular and supraventricular ectopy).

### Design notes

* **`category` is fixed to `procedure`.** The HL7 observation-category
  CodeSystem has no `cardiac` code; cardiology measurements are
  classified as `procedure` per the FHIR
  [Vital Signs](http://hl7.org/fhir/observation-vitalsigns.html) and
  [ECG](http://hl7.org/fhir/ecg.html) guidance.
* **Panel grouper on `Observation.code`.** When related metrics are
  recorded over the same period (AFib burden + episodes + longest
  episode, sinus pause count + longest pause, …) the parent
  `Observation.code` carries a panel grouper code and each metric is
  carried on a separate `component`. The parent code is never reused on
  a component. Where LOINC has no panel concept, a Tiro local code from
  `TiroCardiacMetric` is used.
* **LOINC-first coding.** Individual ECG intervals and 24h heart rate
  min/max use the verified LOINC concepts (see the LOINC table on
  issue #11). Metrics with no LOINC equivalent fall back to
  `TiroCardiacMetric`.
"""

* category 1..* MS
* category ^slicing.discriminator.type = #pattern
* category ^slicing.discriminator.path = "$this"
* category ^slicing.rules = #open
* category contains procedure 1..1 MS
* category[procedure] = $ObsCat#procedure "Procedure"

* status 1..1 MS

* code 1..1 MS
* code ^short = "What was measured or assessed (ECG interval, Holter metric, panel grouper, …)"

* effective[x] 0..1 MS
* effective[x] only dateTime or Period
* effective[x] ^short = "When the measurement was acquired. Use Period for Holter recordings."

* method 0..1 MS
* method ^short = "Procedure that produced the measurement (resting 12-lead ECG, 24h Holter monitoring, …)"

* component 0..*
* component ^short = "Metrics captured together on the same recording (e.g. AFib burden + episode count + longest episode)."
* component.code 1..1 MS
* component.value[x] 1..1 MS


// ─────────────────────────────────────────────────────────────────────
// ECG examples (resting 12-lead)
// ─────────────────────────────────────────────────────────────────────

Instance: example-ecg-heart-rate
InstanceOf: CardiacMeasurement
Usage: #example
Title: "Example: ECG heart rate (72 bpm)"
Description: "Resting heart rate from a 12-lead ECG."
* status = #final
* category[procedure] = $ObsCat#procedure "Procedure"
* code = $LOINC#8867-4 "Heart rate"
* valueQuantity = 72 $UCUM#/min "beats per minute"
* method = $SCT#29303009 "Electrocardiographic procedure"
* effectiveDateTime = "2026-05-12T09:14:00+02:00"


Instance: example-ecg-pr-interval
InstanceOf: CardiacMeasurement
Usage: #example
Title: "Example: ECG PR interval (160 ms)"
Description: "PR interval from a 12-lead ECG."
* status = #final
* category[procedure] = $ObsCat#procedure "Procedure"
* code = $LOINC#8625-6 "P-R interval"
* valueQuantity = 160 $UCUM#ms "ms"
* method = $SCT#29303009 "Electrocardiographic procedure"
* effectiveDateTime = "2026-05-12T09:14:00+02:00"


Instance: example-ecg-qrs-duration
InstanceOf: CardiacMeasurement
Usage: #example
Title: "Example: ECG QRS duration (92 ms)"
Description: "QRS complex duration from a 12-lead ECG."
* status = #final
* category[procedure] = $ObsCat#procedure "Procedure"
* code = $LOINC#8633-0 "QRS duration"
* valueQuantity = 92 $UCUM#ms "ms"
* method = $SCT#29303009 "Electrocardiographic procedure"
* effectiveDateTime = "2026-05-12T09:14:00+02:00"


Instance: example-ecg-qt-interval
InstanceOf: CardiacMeasurement
Usage: #example
Title: "Example: ECG QT interval (380 ms)"
Description: "QT interval from a 12-lead ECG (uncorrected)."
* status = #final
* category[procedure] = $ObsCat#procedure "Procedure"
* code = $LOINC#8634-8 "Q-T interval"
* valueQuantity = 380 $UCUM#ms "ms"
* method = $SCT#29303009 "Electrocardiographic procedure"
* effectiveDateTime = "2026-05-12T09:14:00+02:00"


Instance: example-ecg-qtc-bazett
InstanceOf: CardiacMeasurement
Usage: #example
Title: "Example: ECG QTc Bazett (415 ms)"
Description: "QT interval corrected by Bazett's formula."
* status = #final
* category[procedure] = $ObsCat#procedure "Procedure"
* code = $LOINC#76635-2 "QTc interval by Bazett formula"
* valueQuantity = 415 $UCUM#ms "ms"
* method = $SCT#29303009 "Electrocardiographic procedure"
* effectiveDateTime = "2026-05-12T09:14:00+02:00"


Instance: example-ecg-qtc-fridericia
InstanceOf: CardiacMeasurement
Usage: #example
Title: "Example: ECG QTc Fridericia (405 ms)"
Description: "QT interval corrected by Fridericia's formula."
* status = #final
* category[procedure] = $ObsCat#procedure "Procedure"
* code = $LOINC#76634-5 "QTc interval by Fridericia formula"
* valueQuantity = 405 $UCUM#ms "ms"
* method = $SCT#29303009 "Electrocardiographic procedure"
* effectiveDateTime = "2026-05-12T09:14:00+02:00"


Instance: example-ecg-p-duration
InstanceOf: CardiacMeasurement
Usage: #example
Title: "Example: ECG P wave duration (98 ms)"
Description: "P wave duration from a 12-lead ECG."
* status = #final
* category[procedure] = $ObsCat#procedure "Procedure"
* code = $LOINC#8632-2 "P wave duration"
* valueQuantity = 98 $UCUM#ms "ms"
* method = $SCT#29303009 "Electrocardiographic procedure"
* effectiveDateTime = "2026-05-12T09:14:00+02:00"


Instance: example-ecg-interpretation
InstanceOf: CardiacMeasurement
Usage: #example
Title: "Example: ECG interpretation (sinus rhythm)"
Description: """
Cardiologist's overall impression of a 12-lead ECG. Uses LOINC 8601-0
(EKG impression) — not LOINC 2230-1, which codes epinephrine in plasma.
"""
* status = #final
* category[procedure] = $ObsCat#procedure "Procedure"
* code = $LOINC#8601-0 "EKG impression"
* valueCodeableConcept = $SCT#426177001 "Normal sinus rhythm"
* method = $SCT#29303009 "Electrocardiographic procedure"
* effectiveDateTime = "2026-05-12T09:14:00+02:00"


// ─────────────────────────────────────────────────────────────────────
// Holter examples (24h ambulatory monitoring)
// ─────────────────────────────────────────────────────────────────────

Instance: example-holter-heart-rate-24h
InstanceOf: CardiacMeasurement
Usage: #example
Title: "Example: Holter 24h heart rate (avg 78, min 48, max 132 bpm)"
Description: """
24h heart rate summary from a Holter recording, as a panel with average
on the parent value and min/max on components. The parent uses a Tiro
panel grouper code because LOINC has no 24h-HR panel concept; the
components use the verified LOINC 24h-HR codes.
"""
* status = #final
* category[procedure] = $ObsCat#procedure "Procedure"
* code = TiroCardiacMetric#heart-rate-24h-panel "Heart rate 24h Holter panel"
* method = $SCT#86184003 "Electrocardiographic ambulatory monitoring"
* effectivePeriod.start = "2026-05-10T08:00:00+02:00"
* effectivePeriod.end   = "2026-05-11T08:00:00+02:00"
* component[0].code = $LOINC#8884-9 "Heart rate 24 hour mean"
* component[=].valueQuantity = 78 $UCUM#/min "beats per minute"
* component[+].code = $LOINC#8873-2 "Heart rate--24 hour maximum"
* component[=].valueQuantity = 132 $UCUM#/min "beats per minute"
* component[+].code = $LOINC#8883-1 "Heart rate--24 hour minimum"
* component[=].valueQuantity = 48 $UCUM#/min "beats per minute"


Instance: example-holter-afib
InstanceOf: CardiacMeasurement
Usage: #example
Title: "Example: Holter atrial fibrillation panel"
Description: """
Atrial fibrillation summary from a 24h Holter recording: burden,
episode count, longest episode. The parent carries a panel grouper
code; the metrics each appear on a component. None of these metrics
have a LOINC equivalent today, so component codes come from
`TiroCardiacMetric`.
"""
* status = #final
* category[procedure] = $ObsCat#procedure "Procedure"
* code = TiroCardiacMetric#afib-panel "Atrial fibrillation Holter panel"
* method = $SCT#86184003 "Electrocardiographic ambulatory monitoring"
* effectivePeriod.start = "2026-05-10T08:00:00+02:00"
* effectivePeriod.end   = "2026-05-11T08:00:00+02:00"
* component[0].code = TiroCardiacMetric#afib-burden "Atrial fibrillation burden"
* component[=].valueQuantity = 12.5 $UCUM#% "%"
* component[+].code = TiroCardiacMetric#afib-episode-count "Atrial fibrillation episode count"
* component[=].valueQuantity = 7 $UCUM#1 "{count}"
* component[+].code = TiroCardiacMetric#afib-longest-episode "Atrial fibrillation longest episode duration"
* component[=].valueQuantity = 412 $UCUM#s "s"


Instance: example-holter-pause
InstanceOf: CardiacMeasurement
Usage: #example
Title: "Example: Holter sinus pause panel"
Description: """
Sinus pause summary from a 24h Holter recording: pause count and
longest pause duration. Parent code is a Tiro panel grouper (LOINC has
no pause panel); components use Tiro local codes.
"""
* status = #final
* category[procedure] = $ObsCat#procedure "Procedure"
* code = TiroCardiacMetric#pause-panel "Sinus pause Holter panel"
* method = $SCT#86184003 "Electrocardiographic ambulatory monitoring"
* effectivePeriod.start = "2026-05-10T08:00:00+02:00"
* effectivePeriod.end   = "2026-05-11T08:00:00+02:00"
* component[0].code = TiroCardiacMetric#pause-count "Sinus pause count"
* component[=].valueQuantity = 3 $UCUM#1 "{count}"
* component[+].code = TiroCardiacMetric#longest-pause "Longest sinus pause duration"
* component[=].valueQuantity = 2.8 $UCUM#s "s"


Instance: example-holter-ventricular-ectopy
InstanceOf: CardiacMeasurement
Usage: #example
Title: "Example: Holter ventricular ectopy panel"
Description: """
Ventricular ectopy summary from a 24h Holter recording: total PVC
count and the longest VT run length. Parent is a Tiro panel grouper;
components are Tiro local codes.
"""
* status = #final
* category[procedure] = $ObsCat#procedure "Procedure"
* code = TiroCardiacMetric#ventricular-ectopy-panel "Ventricular ectopy Holter panel"
* method = $SCT#86184003 "Electrocardiographic ambulatory monitoring"
* effectivePeriod.start = "2026-05-10T08:00:00+02:00"
* effectivePeriod.end   = "2026-05-11T08:00:00+02:00"
* component[0].code = TiroCardiacMetric#pvc-count "Premature ventricular contraction count"
* component[=].valueQuantity = 248 $UCUM#1 "{count}"
* component[+].code = TiroCardiacMetric#vt-run-count "Ventricular tachycardia run count"
* component[=].valueQuantity = 2 $UCUM#1 "{count}"
* component[+].code = TiroCardiacMetric#vt-longest-run "Ventricular tachycardia longest run length"
* component[=].valueQuantity = 5 $UCUM#1 "{beats}"


Instance: example-holter-supraventricular-ectopy
InstanceOf: CardiacMeasurement
Usage: #example
Title: "Example: Holter supraventricular ectopy panel"
Description: """
Supraventricular ectopy summary from a 24h Holter recording: total
SVEB count and SVT run statistics. Parent is a Tiro panel grouper;
components are Tiro local codes.
"""
* status = #final
* category[procedure] = $ObsCat#procedure "Procedure"
* code = TiroCardiacMetric#supraventricular-ectopy-panel "Supraventricular ectopy Holter panel"
* method = $SCT#86184003 "Electrocardiographic ambulatory monitoring"
* effectivePeriod.start = "2026-05-10T08:00:00+02:00"
* effectivePeriod.end   = "2026-05-11T08:00:00+02:00"
* component[0].code = TiroCardiacMetric#sveb-count "Supraventricular ectopic beat count"
* component[=].valueQuantity = 94 $UCUM#1 "{count}"
* component[+].code = TiroCardiacMetric#svt-run-count "Supraventricular tachycardia run count"
* component[=].valueQuantity = 4 $UCUM#1 "{count}"
* component[+].code = TiroCardiacMetric#svt-longest-run "Supraventricular tachycardia longest run length"
* component[=].valueQuantity = 8 $UCUM#1 "{beats}"


Instance: example-holter-qtc
InstanceOf: CardiacMeasurement
Usage: #example
Title: "Example: Holter QTc (420 ms)"
Description: "Corrected QT interval derived from a 24h Holter recording."
* status = #final
* category[procedure] = $ObsCat#procedure "Procedure"
* code = $LOINC#8636-3 "Q-T interval corrected"
* valueQuantity = 420 $UCUM#ms "ms"
* method = $SCT#86184003 "Electrocardiographic ambulatory monitoring"
* effectivePeriod.start = "2026-05-10T08:00:00+02:00"
* effectivePeriod.end   = "2026-05-11T08:00:00+02:00"

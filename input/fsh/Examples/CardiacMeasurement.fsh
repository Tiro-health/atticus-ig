Alias: $SCT = http://snomed.info/sct
Alias: $LOINC = http://loinc.org
Alias: $UCUM = http://unitsofmeasure.org
Alias: $ObsCat = http://terminology.hl7.org/CodeSystem/observation-category

CodeSystem: TiroCardiacMetric
Id: tiro-cardiac-metric
Title: "Tiro Cardiac Metric Codes"
Description: """
Local codes for cardiac monitoring metrics that have no equivalent in LOINC
or SNOMED CT. The set is deliberately small: each Tiro code documents a
genuine terminology gap (AFib burden / episode statistics, sinus pause
counts and longest pause, ventricular- and supraventricular-tachycardia
run counts and longest runs, and per-panel Holter grouper codes that
LOINC does not currently provide).

Codes covered by LOINC or SNOMED CT are NOT duplicated here — see the
example instances for the chosen LOINC/SCT codes (PVC count `LOINC#76126-2`,
premature atrial contractions `LOINC#8615-7`, atrial fibrillation
`SCT#49436004`, …).

These codes are a stopgap. Each entry should be replaced with a LOINC or
SNOMED CT code as soon as a suitable concept becomes available.
"""
* ^url = "http://fhir.tiro.health/CodeSystem/tiro-cardiac-metric"
* ^content = #complete
* ^experimental = false
* ^caseSensitive = true

// Panel grouper codes (used on parent Observation.code) — LOINC has no
// equivalent Holter summary panels for these. (24h heart rate uses the
// real LOINC panel `43149-4` "Heart rate device panel" with a clarifying
// `code.text`; no Tiro code needed there.)
* #pause-panel "Sinus pause Holter panel"
* #ventricular-ectopy-panel "Ventricular ectopy Holter panel"
* #supraventricular-ectopy-panel "Supraventricular ectopy Holter panel"

// AFib component metrics — no LOINC equivalents.
* #afib-burden "Atrial fibrillation burden (% of recording in AF)"
* #afib-episode-count "Atrial fibrillation episode count"
* #afib-longest-episode "Atrial fibrillation longest episode duration"

// Sinus pause component metrics — no LOINC equivalents.
* #pause-count "Sinus pause count"
* #longest-pause "Longest sinus pause duration"

// Ventricular tachycardia longest run — no LOINC equivalent. PVC count
// uses LOINC#76126-2 directly and is not duplicated here.
* #vt-longest-run "Ventricular tachycardia longest run length"

// Supraventricular tachycardia run count — no LOINC equivalent. SVEB
// count uses LOINC#8615-7 "Premature atrial contractions" and is not
// duplicated here.
* #svt-run-count "Supraventricular tachycardia run count"


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
* subject = Reference(AZMMTestPatient1)
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
* subject = Reference(AZMMTestPatient1)
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
* subject = Reference(AZMMTestPatient1)
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
* subject = Reference(AZMMTestPatient1)
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
* subject = Reference(AZMMTestPatient1)
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
* subject = Reference(AZMMTestPatient1)
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
* subject = Reference(AZMMTestPatient1)
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
Cardiologist's overall impression of a 12-lead ECG. Uses LOINC 8601-7
(EKG impression) — not LOINC 2230-1, which codes epinephrine in plasma.

Note: issue #11's table cites `8601-0`, but the LOINC concept for
"EKG impression" is actually `8601-7` (verified on loinc.org and used
by HL7 US Core). `8601-0` does not exist.
"""
* status = #final
* subject = Reference(AZMMTestPatient1)
* category[procedure] = $ObsCat#procedure "Procedure"
* code = $LOINC#8601-7 "EKG impression"
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
24h heart rate summary from a Holter recording, with min / mean / max on
components. Parent code is LOINC `43149-4` "Heart rate device panel" —
the closest LOINC panel concept; its defined members only cover the
mean-by-time-window side (`41924-2` is one of them), so `code.text`
clarifies that this instance also carries 24h max and 24h min. Component
codes use the verified LOINC 24h-HR concepts (min `8883-1`, mean
`41924-2`, max `8873-2`).
"""
* status = #final
* subject = Reference(AZMMTestPatient1)
* category[procedure] = $ObsCat#procedure "Procedure"
* code = $LOINC#43149-4 "Heart rate device panel"
* code.text = "Holter 24h heart rate summary (mean / max / min)"
* method = $SCT#86184003 "Electrocardiographic ambulatory monitoring"
* effectivePeriod.start = "2026-05-10T08:00:00+02:00"
* effectivePeriod.end   = "2026-05-11T08:00:00+02:00"
* component[0].code = $LOINC#41924-2 "Heart rate 24 hour mean"
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
episode count, longest episode. Parent code is `SCT#49436004 Atrial
fibrillation` — the clinical finding being characterized — and each
metric is carried on a component. None of the metrics has a LOINC
equivalent today, so component codes come from `TiroCardiacMetric`.
"""
* status = #final
* subject = Reference(AZMMTestPatient1)
* category[procedure] = $ObsCat#procedure "Procedure"
* code = $SCT#49436004 "Atrial fibrillation"
* method = $SCT#86184003 "Electrocardiographic ambulatory monitoring"
* effectivePeriod.start = "2026-05-10T08:00:00+02:00"
* effectivePeriod.end   = "2026-05-11T08:00:00+02:00"
* component[0].code = TiroCardiacMetric#afib-burden "Atrial fibrillation burden"
* component[=].valueQuantity = 12.5 $UCUM#% "%"
* component[+].code = TiroCardiacMetric#afib-episode-count "Atrial fibrillation episode count"
* component[=].valueQuantity = 7 $UCUM#1 "{episodes}"
* component[+].code = TiroCardiacMetric#afib-longest-episode "Atrial fibrillation longest episode duration"
* component[=].valueQuantity = 23 $UCUM#min "min"


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
* subject = Reference(AZMMTestPatient1)
* category[procedure] = $ObsCat#procedure "Procedure"
* code = TiroCardiacMetric#pause-panel "Sinus pause Holter panel"
* method = $SCT#86184003 "Electrocardiographic ambulatory monitoring"
* effectivePeriod.start = "2026-05-10T08:00:00+02:00"
* effectivePeriod.end   = "2026-05-11T08:00:00+02:00"
* component[0].code = TiroCardiacMetric#pause-count "Sinus pause count"
* component[=].valueQuantity = 3 $UCUM#1 "{events}"
* component[+].code = TiroCardiacMetric#longest-pause "Longest sinus pause duration"
* component[=].valueQuantity = 2.8 $UCUM#s "s"


Instance: example-holter-ventricular-ectopy
InstanceOf: CardiacMeasurement
Usage: #example
Title: "Example: Holter ventricular ectopy panel"
Description: """
Ventricular ectopy summary from a 24h Holter recording: total PVC
count and VT run statistics. PVC count uses LOINC `76126-2`
"Premature ventricular contractions [#]". The VT run statistics and
the panel grouper have no LOINC equivalents, so those come from
`TiroCardiacMetric`.
"""
* status = #final
* subject = Reference(AZMMTestPatient1)
* category[procedure] = $ObsCat#procedure "Procedure"
* code = TiroCardiacMetric#ventricular-ectopy-panel "Ventricular ectopy Holter panel"
* method = $SCT#86184003 "Electrocardiographic ambulatory monitoring"
* effectivePeriod.start = "2026-05-10T08:00:00+02:00"
* effectivePeriod.end   = "2026-05-11T08:00:00+02:00"
* component[0].code = $LOINC#76126-2 "Premature ventricular contractions [#]"
* component[=].valueQuantity = 248 $UCUM#1 "{beats}"
* component[+].code = TiroCardiacMetric#vt-longest-run "Ventricular tachycardia longest run length"
* component[=].valueQuantity = 5 $UCUM#1 "{beats}"


Instance: example-holter-supraventricular-ectopy
InstanceOf: CardiacMeasurement
Usage: #example
Title: "Example: Holter supraventricular ectopy panel"
Description: """
Supraventricular ectopy summary from a 24h Holter recording: total
SVEB count (a supraventricular ectopic beat is, clinically, a
premature atrial contraction) and SVT run statistics. The SVEB count
uses LOINC `8615-7` "Premature atrial contractions". The SVT run
statistics and the panel grouper have no LOINC equivalents and come
from `TiroCardiacMetric`.
"""
* status = #final
* subject = Reference(AZMMTestPatient1)
* category[procedure] = $ObsCat#procedure "Procedure"
* code = TiroCardiacMetric#supraventricular-ectopy-panel "Supraventricular ectopy Holter panel"
* method = $SCT#86184003 "Electrocardiographic ambulatory monitoring"
* effectivePeriod.start = "2026-05-10T08:00:00+02:00"
* effectivePeriod.end   = "2026-05-11T08:00:00+02:00"
* component[0].code = $LOINC#8615-7 "Premature atrial contractions"
* component[=].valueQuantity = 94 $UCUM#1 "{beats}"
* component[+].code = TiroCardiacMetric#svt-run-count "Supraventricular tachycardia run count"
* component[=].valueQuantity = 4 $UCUM#1 "{events}"


Instance: example-holter-qtc
InstanceOf: CardiacMeasurement
Usage: #example
Title: "Example: Holter QTc (420 ms)"
Description: "Corrected QT interval derived from a 24h Holter recording."
* status = #final
* subject = Reference(AZMMTestPatient1)
* category[procedure] = $ObsCat#procedure "Procedure"
* code = $LOINC#8636-3 "Q-T interval corrected"
* valueQuantity = 420 $UCUM#ms "ms"
* method = $SCT#86184003 "Electrocardiographic ambulatory monitoring"
* effectivePeriod.start = "2026-05-10T08:00:00+02:00"
* effectivePeriod.end   = "2026-05-11T08:00:00+02:00"


// ─────────────────────────────────────────────────────────────────────
// AZMM test patient — referenced by every example in this file.
// Per Joeri Christiaens (AZMM, mail 2026-05-19): instead of creating
// per-recording Patient resources, point Holter/ECG Observations at one
// of the two existing AZMM test patients.
// ─────────────────────────────────────────────────────────────────────

Instance: AZMMTestPatient1
InstanceOf: Patient
Usage: #example
Title: "AZMM test patient 1 (lS8whV3.114131)"
Description: "Existing AZMM test patient already used in AZMM ↔ Tiro.health interop testing. The id mirrors the literal id used on AZMM's FHIR endpoint so Observations created here resolve there."
* identifier.system = "https://fhir-ns.mijnziekenhuis.be/id/patient/azmm"
* identifier.value = "lS8whV3.114131"


// ─────────────────────────────────────────────────────────────────────
// CardiacVitalSigns profile — for the real-time / flowsheet feed case
// (avg HR from a Holter or telemetry recording landing on a vital-signs
// flowsheet). Per Joeri Christiaens (mail 2026-05-19), Holter
// Observations are not always category=procedure: a hospital may also
// emit recurring averages that belong in vital-signs.
//
// Profile is a sibling, not a child, of CardiacMeasurement because the
// fixed `category` value differs.
// ─────────────────────────────────────────────────────────────────────

Profile: CardiacVitalSigns
Parent: Observation
Id: CardiacVitalSigns
Title: "Cardiac Vital Signs"
Description: """
FHIR Observation profile for cardiac measurements that flow into a
vital-signs / flowsheet stream rather than into a final cardiology
report. Typical use case: a Holter device emits a rolling average heart
rate every hour and those values are written as discrete vital-signs
Observations.

`category` is fixed to `vital-signs` (the HL7 observation-category
code) — this is the distinguishing constraint from `CardiacMeasurement`,
which fixes `category` to `procedure`. Use `CardiacMeasurement` for the
cardiologist's final report and panel-style summaries; use this profile
for individual real-time measurements.
"""

* category 1..* MS
* category ^slicing.discriminator.type = #pattern
* category ^slicing.discriminator.path = "$this"
* category ^slicing.rules = #open
* category contains vitalSigns 1..1 MS
* category[vitalSigns] = $ObsCat#vital-signs "Vital Signs"

* status 1..1 MS
* code 1..1 MS
* subject 1..1 MS
* effective[x] 1..1 MS
* effective[x] only dateTime or Period


Instance: example-holter-heart-rate-vitals
InstanceOf: CardiacVitalSigns
Usage: #example
Title: "Example: Holter rolling average heart rate (78 bpm)"
Description: """
A single rolling-window average heart rate from a Holter monitor
landing on the patient's flowsheet. Equivalent to Laurent Ganton's
`CreateObservationEntry(Holter,…)` path (Fhir_Holter.txt l.5-9), which
already emits `category = vital-signs`.
"""
* status = #final
* subject = Reference(AZMMTestPatient1)
* category[vitalSigns] = $ObsCat#vital-signs "Vital Signs"
* code = $LOINC#8867-4 "Heart rate"
* valueQuantity = 78 $UCUM#/min "beats per minute"
* effectiveDateTime = "2026-05-10T09:00:00+02:00"

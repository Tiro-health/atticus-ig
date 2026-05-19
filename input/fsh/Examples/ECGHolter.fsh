Alias: $SCT = http://snomed.info/sct
Alias: $UCUM = http://unitsofmeasure.org
Alias: $LOINC = http://loinc.org
Alias: $ObsCat = http://terminology.hl7.org/CodeSystem/observation-category

// -----------------------------------------------------------------------------
// Local CodeSystem for Holter analytics that have no LOINC equivalent.
//
// Several metrics produced by Holter analysis software (AFib burden, pause
// statistics, ventricular and supraventricular ectopic beat counts, run
// counts) are not represented in LOINC. The implementation we reviewed used
// codes in the 5159-8 — 5191-1 range that either don't exist or map to
// unrelated concepts. This CodeSystem provides stable codes for those
// metrics. Panel codes (suffix "-panel") group related metrics on a single
// Observation; the individual measurements live in `Observation.component`
// and carry the matching measurement code.
// -----------------------------------------------------------------------------
CodeSystem: HolterMetrics
Id: holter-metrics
Title: "Holter Monitoring Metrics"
Description: "Codes for Holter ambulatory ECG metrics that have no LOINC equivalent. Panel codes are used on Observation.code; measurement codes are used on Observation.component.code."
* ^url = "http://fhir.tiro.health/CodeSystem/holter-metrics"
* ^content = #complete
* ^experimental = false
* ^caseSensitive = true
// Panel groupers
* #afib-panel "AFib summary panel" "Panel grouping atrial fibrillation metrics derived from a Holter recording."
* #pause-panel "Pause summary panel" "Panel grouping pause metrics derived from a Holter recording."
* #pvc-panel "Ventricular ectopy panel" "Panel grouping premature ventricular contraction and ventricular tachycardia metrics."
* #sveb-panel "Supraventricular ectopy panel" "Panel grouping supraventricular ectopic beat and supraventricular tachycardia metrics."
// AFib measurements
* #afib-burden "AFib burden" "Fraction of the recording period spent in atrial fibrillation, expressed as a percentage."
* #afib-episode-count "AFib episode count" "Number of distinct atrial fibrillation episodes detected during the recording."
* #afib-longest-episode "Longest AFib episode duration" "Duration of the longest atrial fibrillation episode in the recording."
// Pause measurements
* #pause-count "Pause count" "Number of pauses (R-R interval exceeding the configured threshold) detected during the recording."
* #longest-pause "Longest pause duration" "Duration of the longest pause detected during the recording."
// Ventricular ectopy measurements
* #pvc-count "PVC count" "Total number of premature ventricular contractions detected during the recording."
* #vt-run-count "VT run count" "Number of ventricular tachycardia runs (≥3 consecutive ventricular beats) detected during the recording."
// Supraventricular ectopy measurements
* #sveb-count "SVEB count" "Total number of supraventricular ectopic beats detected during the recording."
* #svt-run-count "SVT run count" "Number of supraventricular tachycardia runs detected during the recording."


// -----------------------------------------------------------------------------
// CardiacMeasurement profile
//
// Mirrors the LabMeasurement profile: an ObservationDefinition that describes
// a single cardiac measurement (a coded concept, its permitted data type, and
// the units it can be reported in). Concrete Observation instances further
// down in this file populate values that conform to one of these definitions.
// -----------------------------------------------------------------------------
Profile: CardiacMeasurement
Parent: ObservationDefinition
Id: CardiacMeasurement
Title: "Cardiac Measurement"
Description: "Definition of a single cardiac measurement (ECG, Holter, …). Captures the code that identifies the measurement, the permitted FHIR data type and — for quantitative measurements — the permitted units."
* code 1..1 MS
* permittedDataType 1..* MS
* permittedUnit 0..* MS


// ECG measurement definitions
Instance: HeartRate
InstanceOf: CardiacMeasurement
Usage: #example
Title: "Heart rate"
Description: "Instantaneous heart rate measured from an ECG."
* status = #active
* code = $LOINC#8867-4 "Heart rate"
* permittedDataType = #Quantity
* permittedUnit = $UCUM#/min "beats/minute"

Instance: PRInterval
InstanceOf: CardiacMeasurement
Usage: #example
Title: "PR interval"
Description: "PR interval measured from an ECG. LOINC 8625-6 (`8625-9` does not exist)."
* status = #active
* code = $LOINC#8625-6 "P-R Interval"
* permittedDataType = #Quantity
* permittedUnit = $UCUM#ms "milliseconds"

Instance: QRSDuration
InstanceOf: CardiacMeasurement
Usage: #example
Title: "QRS duration"
Description: "QRS duration measured from an ECG. LOINC 8633-0 (`8633-2` does not exist)."
* status = #active
* code = $LOINC#8633-0 "QRS duration"
* permittedDataType = #Quantity
* permittedUnit = $UCUM#ms "milliseconds"

Instance: PWaveDuration
InstanceOf: CardiacMeasurement
Usage: #example
Title: "P wave duration"
Description: "P wave duration measured from an ECG."
* status = #active
* code = $LOINC#8626-4 "P wave duration"
* permittedDataType = #Quantity
* permittedUnit = $UCUM#ms "milliseconds"

Instance: QTInterval
InstanceOf: CardiacMeasurement
Usage: #example
Title: "QT interval"
Description: "QT interval measured from an ECG. LOINC 8634-8 (`8636-5` does not exist)."
* status = #active
* code = $LOINC#8634-8 "Q-T interval"
* permittedDataType = #Quantity
* permittedUnit = $UCUM#ms "milliseconds"

Instance: QTcBazett
InstanceOf: CardiacMeasurement
Usage: #example
Title: "QTc (Bazett)"
Description: "Rate-corrected QT interval using Bazett's formula. LOINC 76635-2 (`5195-2` does not exist)."
* status = #active
* code = $LOINC#76635-2 "QT interval corrected by Bazett formula"
* permittedDataType = #Quantity
* permittedUnit = $UCUM#ms "milliseconds"

Instance: QTcFridericia
InstanceOf: CardiacMeasurement
Usage: #example
Title: "QTc (Fridericia)"
Description: "Rate-corrected QT interval using Fridericia's formula. LOINC 76634-5 (`5196-0` does not exist)."
* status = #active
* code = $LOINC#76634-5 "QT interval corrected by Fridericia formula"
* permittedDataType = #Quantity
* permittedUnit = $UCUM#ms "milliseconds"

Instance: QTcGeneric
InstanceOf: CardiacMeasurement
Usage: #example
Title: "QTc (formula unspecified)"
Description: "Rate-corrected QT interval where the correction formula is conveyed via Observation.method rather than the code itself. LOINC 8636-3 (`8637-3` does not exist)."
* status = #active
* code = $LOINC#8636-3 "Q-T interval corrected"
* permittedDataType = #Quantity
* permittedUnit = $UCUM#ms "milliseconds"

Instance: ECGInterpretation
InstanceOf: CardiacMeasurement
Usage: #example
Title: "ECG interpretation"
Description: "Cardiologist's overall ECG impression. LOINC 8601-0 (`2230-1` is Epinephrine in plasma)."
* status = #active
* code = $LOINC#8601-0 "EKG impression"
* permittedDataType = #string

// Holter measurement definitions
Instance: Holter24hHRAverage
InstanceOf: CardiacMeasurement
Usage: #example
Title: "Holter 24h average heart rate"
Description: "Average heart rate over a 24h Holter recording."
* status = #active
* code = $LOINC#55425-3 "Heart rate.average 24 hour"
* permittedDataType = #Quantity
* permittedUnit = $UCUM#/min "beats/minute"

Instance: Holter24hHRMax
InstanceOf: CardiacMeasurement
Usage: #example
Title: "Holter 24h maximum heart rate"
Description: "Maximum heart rate over a 24h Holter recording. LOINC 8873-2 (`8879-1` is unrelated)."
* status = #active
* code = $LOINC#8873-2 "Heart rate --24 hour maximum"
* permittedDataType = #Quantity
* permittedUnit = $UCUM#/min "beats/minute"

Instance: Holter24hHRMin
InstanceOf: CardiacMeasurement
Usage: #example
Title: "Holter 24h minimum heart rate"
Description: "Minimum heart rate over a 24h Holter recording. LOINC 8883-1 (`8880-9` is unrelated)."
* status = #active
* code = $LOINC#8883-1 "Heart rate --24 hour minimum"
* permittedDataType = #Quantity
* permittedUnit = $UCUM#/min "beats/minute"

Instance: HolterAFibBurden
InstanceOf: CardiacMeasurement
Usage: #example
Title: "AFib burden"
Description: "Fraction of the Holter recording period spent in atrial fibrillation."
* status = #active
* code = HolterMetrics#afib-burden "AFib burden"
* permittedDataType = #Quantity
* permittedUnit = $UCUM#% "percent"

Instance: HolterAFibEpisodeCount
InstanceOf: CardiacMeasurement
Usage: #example
Title: "AFib episode count"
Description: "Number of atrial fibrillation episodes detected during a Holter recording."
* status = #active
* code = HolterMetrics#afib-episode-count "AFib episode count"
* permittedDataType = #Quantity
* permittedUnit = $UCUM#1 "{events}"

Instance: HolterAFibLongestEpisode
InstanceOf: CardiacMeasurement
Usage: #example
Title: "Longest AFib episode"
Description: "Duration of the longest atrial fibrillation episode in a Holter recording."
* status = #active
* code = HolterMetrics#afib-longest-episode "Longest AFib episode duration"
* permittedDataType = #Quantity
* permittedUnit[0] = $UCUM#s "seconds"
* permittedUnit[+] = $UCUM#min "minutes"

Instance: HolterPauseCount
InstanceOf: CardiacMeasurement
Usage: #example
Title: "Pause count"
Description: "Number of pauses (R-R > configured threshold) detected during a Holter recording."
* status = #active
* code = HolterMetrics#pause-count "Pause count"
* permittedDataType = #Quantity
* permittedUnit = $UCUM#1 "{events}"

Instance: HolterLongestPause
InstanceOf: CardiacMeasurement
Usage: #example
Title: "Longest pause"
Description: "Duration of the longest pause detected during a Holter recording."
* status = #active
* code = HolterMetrics#longest-pause "Longest pause duration"
* permittedDataType = #Quantity
* permittedUnit = $UCUM#s "seconds"

Instance: HolterPVCCount
InstanceOf: CardiacMeasurement
Usage: #example
Title: "PVC count"
Description: "Total number of premature ventricular contractions detected during a Holter recording."
* status = #active
* code = HolterMetrics#pvc-count "PVC count"
* permittedDataType = #Quantity
* permittedUnit = $UCUM#1 "{events}"

Instance: HolterVTRunCount
InstanceOf: CardiacMeasurement
Usage: #example
Title: "VT run count"
Description: "Number of ventricular tachycardia runs detected during a Holter recording."
* status = #active
* code = HolterMetrics#vt-run-count "VT run count"
* permittedDataType = #Quantity
* permittedUnit = $UCUM#1 "{runs}"

Instance: HolterSVEBCount
InstanceOf: CardiacMeasurement
Usage: #example
Title: "SVEB count"
Description: "Total number of supraventricular ectopic beats detected during a Holter recording."
* status = #active
* code = HolterMetrics#sveb-count "SVEB count"
* permittedDataType = #Quantity
* permittedUnit = $UCUM#1 "{events}"

Instance: HolterSVTRunCount
InstanceOf: CardiacMeasurement
Usage: #example
Title: "SVT run count"
Description: "Number of supraventricular tachycardia runs detected during a Holter recording."
* status = #active
* code = HolterMetrics#svt-run-count "SVT run count"
* permittedDataType = #Quantity
* permittedUnit = $UCUM#1 "{runs}"


// -----------------------------------------------------------------------------
// ECG examples
//
// All ECG observations share:
//   - category = procedure (the only valid code in observation-category
//     for cardiology procedure-derived measurements; `cardiac` is not in
//     that CodeSystem)
//   - subject and effective time pointing at the same ECG acquisition
//
// LOINC codes have been verified against tx.fhir.org / CodeSystem/$lookup.
// -----------------------------------------------------------------------------

Instance: ECGPatient
InstanceOf: Patient
Usage: #example
Title: "ECG Example Patient"
Description: "Sample patient used by the ECG and Holter example Observations."
* name.family = "Doe"
* name.given = "Jane"
* gender = #female
* birthDate = "1968-03-12"

Instance: ecg-heart-rate
InstanceOf: Observation
Usage: #example
Title: "ECG — Heart rate"
Description: "Heart rate measured from a resting 12-lead ECG."
* status = #final
* category = $ObsCat#procedure "Procedure"
* code = $LOINC#8867-4 "Heart rate"
* subject = Reference(ECGPatient)
* effectiveDateTime = "2026-05-18T09:14:00+02:00"
* valueQuantity = 72 $UCUM#/min "beats/minute"

Instance: ecg-pr-interval
InstanceOf: Observation
Usage: #example
Title: "ECG — PR interval"
Description: "PR interval measured from a resting 12-lead ECG. Uses LOINC 8625-6 (P-R Interval); the value `8625-9` used in some implementations does not exist."
* status = #final
* category = $ObsCat#procedure "Procedure"
* code = $LOINC#8625-6 "P-R Interval"
* subject = Reference(ECGPatient)
* effectiveDateTime = "2026-05-18T09:14:00+02:00"
* valueQuantity = 156 $UCUM#ms "milliseconds"

Instance: ecg-qrs-duration
InstanceOf: Observation
Usage: #example
Title: "ECG — QRS duration"
Description: "QRS duration measured from a resting 12-lead ECG. Uses LOINC 8633-0; the value `8633-2` used in some implementations does not exist."
* status = #final
* category = $ObsCat#procedure "Procedure"
* code = $LOINC#8633-0 "QRS duration"
* subject = Reference(ECGPatient)
* effectiveDateTime = "2026-05-18T09:14:00+02:00"
* valueQuantity = 92 $UCUM#ms "milliseconds"

Instance: ecg-p-duration
InstanceOf: Observation
Usage: #example
Title: "ECG — P wave duration"
Description: "P wave duration measured from a resting 12-lead ECG."
* status = #final
* category = $ObsCat#procedure "Procedure"
* code = $LOINC#8626-4 "P wave duration"
* subject = Reference(ECGPatient)
* effectiveDateTime = "2026-05-18T09:14:00+02:00"
* valueQuantity = 98 $UCUM#ms "milliseconds"

Instance: ecg-qt-interval
InstanceOf: Observation
Usage: #example
Title: "ECG — QT interval"
Description: "QT interval measured from a resting 12-lead ECG. Uses LOINC 8634-8 (Q-T interval); the value `8636-5` used in some implementations does not exist."
* status = #final
* category = $ObsCat#procedure "Procedure"
* code = $LOINC#8634-8 "Q-T interval"
* subject = Reference(ECGPatient)
* effectiveDateTime = "2026-05-18T09:14:00+02:00"
* valueQuantity = 388 $UCUM#ms "milliseconds"

Instance: ecg-qtc-bazett
InstanceOf: Observation
Usage: #example
Title: "ECG — QTc (Bazett)"
Description: "Rate-corrected QT interval using Bazett's formula. Uses LOINC 76635-2; the value `5195-2` used in some implementations does not exist."
* status = #final
* category = $ObsCat#procedure "Procedure"
* code = $LOINC#76635-2 "QT interval corrected by Bazett formula"
* subject = Reference(ECGPatient)
* effectiveDateTime = "2026-05-18T09:14:00+02:00"
* valueQuantity = 425 $UCUM#ms "milliseconds"

Instance: ecg-qtc-fridericia
InstanceOf: Observation
Usage: #example
Title: "ECG — QTc (Fridericia)"
Description: "Rate-corrected QT interval using Fridericia's formula. Uses LOINC 76634-5; the value `5196-0` used in some implementations does not exist."
* status = #final
* category = $ObsCat#procedure "Procedure"
* code = $LOINC#76634-5 "QT interval corrected by Fridericia formula"
* subject = Reference(ECGPatient)
* effectiveDateTime = "2026-05-18T09:14:00+02:00"
* valueQuantity = 410 $UCUM#ms "milliseconds"

Instance: ecg-interpretation
InstanceOf: Observation
Usage: #example
Title: "ECG — Interpretation"
Description: "Cardiologist's overall ECG interpretation. Uses LOINC 8601-0 (EKG impression); the value `2230-1` used in some implementations is Epinephrine in plasma."
* status = #final
* category = $ObsCat#procedure "Procedure"
* code = $LOINC#8601-0 "EKG impression"
* subject = Reference(ECGPatient)
* effectiveDateTime = "2026-05-18T09:14:00+02:00"
* valueString = "Normal sinus rhythm. Heart rate 72/min. PR, QRS, QT and QTc within normal limits. No acute ischaemic changes."


// -----------------------------------------------------------------------------
// Holter examples
//
// The Holter recording is represented as several Observation resources that
// share `effectivePeriod` (the full 24h recording window). Metrics that are
// only meaningful together (AFib burden + episode count + longest episode,
// pause count + longest pause, …) are grouped into a single Observation
// using Observation.component, with a panel/grouper code on the parent and
// the specific measurement code on each component.
// -----------------------------------------------------------------------------

Instance: holter-hr-average
InstanceOf: Observation
Usage: #example
Title: "Holter — 24h average heart rate"
Description: "Average heart rate over the full 24h Holter recording."
* status = #final
* category = $ObsCat#procedure "Procedure"
* code = $LOINC#55425-3 "Heart rate.average 24 hour"
* subject = Reference(ECGPatient)
* effectivePeriod.start = "2026-05-17T08:00:00+02:00"
* effectivePeriod.end = "2026-05-18T08:00:00+02:00"
* valueQuantity = 74 $UCUM#/min "beats/minute"

Instance: holter-hr-max
InstanceOf: Observation
Usage: #example
Title: "Holter — 24h maximum heart rate"
Description: "Maximum heart rate over the 24h Holter recording. Uses LOINC 8873-2; the value `8879-1` used in some implementations is unrelated."
* status = #final
* category = $ObsCat#procedure "Procedure"
* code = $LOINC#8873-2 "Heart rate --24 hour maximum"
* subject = Reference(ECGPatient)
* effectivePeriod.start = "2026-05-17T08:00:00+02:00"
* effectivePeriod.end = "2026-05-18T08:00:00+02:00"
* valueQuantity = 132 $UCUM#/min "beats/minute"

Instance: holter-hr-min
InstanceOf: Observation
Usage: #example
Title: "Holter — 24h minimum heart rate"
Description: "Minimum heart rate over the 24h Holter recording. Uses LOINC 8883-1; the value `8880-9` used in some implementations is unrelated."
* status = #final
* category = $ObsCat#procedure "Procedure"
* code = $LOINC#8883-1 "Heart rate --24 hour minimum"
* subject = Reference(ECGPatient)
* effectivePeriod.start = "2026-05-17T08:00:00+02:00"
* effectivePeriod.end = "2026-05-18T08:00:00+02:00"
* valueQuantity = 48 $UCUM#/min "beats/minute"

Instance: holter-afib-panel
InstanceOf: Observation
Usage: #example
Title: "Holter — AFib summary"
Description: """Atrial fibrillation metrics over the recording period. Uses a local panel grouper code on the parent (`afib-panel`) and the matching measurement codes on each component. The implementation we reviewed reused the same code on both the parent Observation and one of its components; that pattern is avoided here."""
* status = #final
* category = $ObsCat#procedure "Procedure"
* code = HolterMetrics#afib-panel "AFib summary panel"
* code.coding[+] = $SCT#49436004 "Atrial fibrillation"
* subject = Reference(ECGPatient)
* effectivePeriod.start = "2026-05-17T08:00:00+02:00"
* effectivePeriod.end = "2026-05-18T08:00:00+02:00"
* component[+].code = HolterMetrics#afib-burden "AFib burden"
* component[=].valueQuantity = 12.4 $UCUM#% "percent"
* component[+].code = HolterMetrics#afib-episode-count "AFib episode count"
* component[=].valueQuantity = 7 $UCUM#1 "{events}"
* component[+].code = HolterMetrics#afib-longest-episode "Longest AFib episode duration"
* component[=].valueQuantity = 1840 $UCUM#s "seconds"

Instance: holter-pause-panel
InstanceOf: Observation
Usage: #example
Title: "Holter — Pause summary"
Description: "Sinus/AV pause metrics over the recording period. Pause threshold is configured in the analysis software (typically R-R > 2.0 s)."
* status = #final
* category = $ObsCat#procedure "Procedure"
* code = HolterMetrics#pause-panel "Pause summary panel"
* subject = Reference(ECGPatient)
* effectivePeriod.start = "2026-05-17T08:00:00+02:00"
* effectivePeriod.end = "2026-05-18T08:00:00+02:00"
* component[+].code = HolterMetrics#pause-count "Pause count"
* component[=].valueQuantity = 4 $UCUM#1 "{events}"
* component[+].code = HolterMetrics#longest-pause "Longest pause duration"
* component[=].valueQuantity = 2.6 $UCUM#s "seconds"

Instance: holter-pvc-panel
InstanceOf: Observation
Usage: #example
Title: "Holter — Ventricular ectopy summary"
Description: "Ventricular ectopy metrics over the recording period: premature ventricular contraction count and ventricular tachycardia run count."
* status = #final
* category = $ObsCat#procedure "Procedure"
* code = HolterMetrics#pvc-panel "Ventricular ectopy panel"
* code.coding[+] = $SCT#17338001 "Premature ventricular contraction"
* subject = Reference(ECGPatient)
* effectivePeriod.start = "2026-05-17T08:00:00+02:00"
* effectivePeriod.end = "2026-05-18T08:00:00+02:00"
* component[+].code = HolterMetrics#pvc-count "PVC count"
* component[=].valueQuantity = 312 $UCUM#1 "{events}"
* component[+].code = HolterMetrics#vt-run-count "VT run count"
* component[=].valueQuantity = 2 $UCUM#1 "{runs}"

Instance: holter-sveb-panel
InstanceOf: Observation
Usage: #example
Title: "Holter — Supraventricular ectopy summary"
Description: "Supraventricular ectopy metrics over the recording period: supraventricular ectopic beat count and supraventricular tachycardia run count."
* status = #final
* category = $ObsCat#procedure "Procedure"
* code = HolterMetrics#sveb-panel "Supraventricular ectopy panel"
* code.coding[+] = $SCT#426995002 "Supraventricular ectopic beats"
* subject = Reference(ECGPatient)
* effectivePeriod.start = "2026-05-17T08:00:00+02:00"
* effectivePeriod.end = "2026-05-18T08:00:00+02:00"
* component[+].code = HolterMetrics#sveb-count "SVEB count"
* component[=].valueQuantity = 88 $UCUM#1 "{events}"
* component[+].code = HolterMetrics#svt-run-count "SVT run count"
* component[=].valueQuantity = 5 $UCUM#1 "{runs}"

Instance: holter-qtc
InstanceOf: Observation
Usage: #example
Title: "Holter — QTc"
Description: "Rate-corrected QT interval reported from the Holter analysis. Uses LOINC 8636-3 (Q-T interval corrected); the specific correction formula can be conveyed via Observation.method when known."
* status = #final
* category = $ObsCat#procedure "Procedure"
* code = $LOINC#8636-3 "Q-T interval corrected"
* subject = Reference(ECGPatient)
* effectivePeriod.start = "2026-05-17T08:00:00+02:00"
* effectivePeriod.end = "2026-05-18T08:00:00+02:00"
* valueQuantity = 432 $UCUM#ms "milliseconds"

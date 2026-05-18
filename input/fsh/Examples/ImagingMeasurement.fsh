Alias: $SCT = http://snomed.info/sct
Alias: $LOINC = http://loinc.org
Alias: $UCUM = http://unitsofmeasure.org
Alias: $ObsCat = http://terminology.hl7.org/CodeSystem/observation-category

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
"""

* category 1..* MS
* category ^slicing.discriminator.type = #pattern
* category ^slicing.discriminator.path = "$this"
* category ^slicing.rules = #open
* category contains imaging 1..1 MS
* category[imaging] = $ObsCat#imaging "Imaging"

* status 1..1 MS

* code 1..1 MS
* code ^short = "Kind of measurement (diameter, volume, area, length, circumference, angle, thickness, …)"

* value[x] 1..1 MS
* value[x] only Quantity
* valueQuantity.system = $UCUM (exactly)

* bodySite 0..1 MS
* bodySite ^short = "Anatomical site of the measured structure"

* focus 0..* MS
* focus ^short = "The tracked lesion or structure being measured (e.g. a BodyStructure for longitudinal RECIST tracking)"

* method 0..1 MS
* method ^short = "Imaging modality or measurement technique (CT, MRI, US, PET, …)"

* derivedFrom 0..* MS
* derivedFrom only Reference(ImagingStudy or DocumentReference or Media or DiagnosticReport)
* derivedFrom ^short = "Source image, study or report the measurement was taken from"

* effective[x] 0..1 MS
* effective[x] only dateTime or Period
* effective[x] ^short = "Image acquisition time (not interpretation time)"

* component 0..*
* component ^short = "Paired measurements captured on the same acquisition (e.g. RECIST long + short axis of one lesion)"
* component.code 1..1 MS
* component.value[x] 1..1 MS
* component.value[x] only Quantity


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

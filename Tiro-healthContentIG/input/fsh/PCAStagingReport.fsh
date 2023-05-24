Instance: DrHause
InstanceOf: Practitioner 
Usage: #example
Title: "Dr. Hause"
Description: "Example medical doctor specialized in urology/oncology"

Instance: PCaPatient
InstanceOf: Patient
Usage: #example
Title: "Prostate Cancer Patient"
Description: "Example patient that is diagnosed with prostate cancer."
* identifier.value = "8242"
* identifier.system = "http://hospital.be/official-patient-id"
* gender = #male
* birthDate = "2023-04-06"

Instance: PCaStagingComposition
InstanceOf: Composition 
Usage: #example
Title: "Prostate Cancer Staging Composition"
Description: "Example of a Composition from a Prostate Cancer Staging report."
* type = LOINC#1234 "Prostate Cancer Consultation"
* date = 2023-05-24
* author = Reference(DrHause)
* title = "Prostate Cancer Staging Composition"
* status = #final
* language = #nl
* section[+].title = "Medische voorgeschiedenis"
* section[=].code = SCT#1003642006 "Past medical history section"
* section[+].title = "Prostaat-gerateerde voorgeschiedenis"
* section[=].code = SCT#422625006 "history of present illness section"
* section[+].title = "Anamnese en klinisch onderzoek"
* section[=].code = SCT#371529009 "History and physical report"
* section[+].title = "Technische onderzoeken"
* section[=].code = SCT#4201000179104 "Imaging report"
* section[+].title = "Staging prostaatkanker"
* section[+].title = "Besluit bij verhoogde PSA"
* section[=].code = SCT#722091001 "Conclusion interpretation document"


Instance: PCacTStage
InstanceOf: Observation
Usage: #example
Title: "PCa T Stage"
Description: ""
* code = SCT#399537006 "Clinical TNM stage grouping (observable entity)"
* status = #registered
* subject = Reference(PCaPatient) 
* valueCodeableConcept.coding = SCT#1228892002 "cT1a"
* valueCodeableConcept.text = "cT1a"
* effectiveDateTime = "2023-05-23T00:00:00+00:00"
* performer = Reference(DrHause)


Instance: PCaEAURisk
InstanceOf: Observation
Usage: #example
Title: "PCa EAU Risk Group"
Description: ""
* code = AUTO#urn:uuid:030861fb-a73f-499a-9e7e-471d720c25cf "EAU risicogroep"
* status = #registered
* subject = Reference(PCaPatient) 
* valueCodeableConcept.coding = SCT#723505004
* valueCodeableConcept.text = "Low risk"
* effectiveDateTime = "2023-05-23T00:00:00+00:00"
* performer = Reference(DrHause)

Instance: PCaGleason
InstanceOf: Observation
Usage: #example
Title: "PCa Gleason Score"
Description: "Gleason Score observatoin"
* code = SCT#372278000 "Gleason score"
* status = #registered
* subject = Reference(PCaPatient) 
* valueString = "3 + 3"
* component[0].code = SCT#384994009 "Primary Gleason pattern"
* component[0].valueCodeableConcept = SCT#369772003 "Gleason pattern 3"
* component[1].code = SCT#384995005 "Secondary Gleason pattern"
* component[1].valueCodeableConcept = SCT#369772003 "Gleason pattern 3"
* effectiveDateTime = "2023-05-23T00:00:00+00:00"
* performer = Reference(DrHause)

Instance: PCaPSA1
InstanceOf: Observation
Usage: #example
Title: "PCA PSA"
Description: "PSA Measurement observation"
* code = SCT#63476009 "Prostate specific antigen measurement"
* status = #registered
* subject = Reference(PCaPatient) 
* valueQuantity.unit = "ng/ml"
* valueQuantity.value = 0.14
* valueQuantity.code = #ng/ml
* valueQuantity.system = "http://unitsofmeasure.org"
* effectiveDateTime = "2023-01-23T00:00:00+00:00"

Instance: PCaPSA2
InstanceOf: Observation
Usage: #example
Title: "PCA PSA"
Description: "PSA Measurement observation"
* code = SCT#63476009 "Prostate specific antigen measurement"
* status = #registered
* subject = Reference(PCaPatient) 
* valueQuantity.unit = "ng/ml"
* valueQuantity.value = 8.4
* valueQuantity.code = #ng/ml
* valueQuantity.system = "http://unitsofmeasure.org"
* effectiveDateTime = "2023-05-20T00:00:00+00:00"

Instance: RaisedPSACondition
InstanceOf: Condition
Usage: #example
Title: "Raised PSA diagnosis"
Description: "Patient is diagnosed with raised PSA."
* code = SCT#396152005
* recordedDate = "2023-05-23T00:00:00+00:00"
* participant[0].actor = Reference(DrHause)
* participant[0].function = http://terminology.hl7.org/CodeSystem/provenance-participant-type#custodian "Custodian"
* participant[0].function.text = "Treating physician"
* clinicalStatus = #active
* subject = Reference(PCaPatient)
* stage.assessment[0] = Reference(PCaPSA1) 
* stage.assessment[1] = Reference(PCaPSA2) 

Instance: PCaCondition
InstanceOf: Condition
Usage: #example
Title: "Prostate Cancer"
Description: "Patient is diagnosed with prostate cancer."
* code = SCT#254900004
* clinicalStatus = #active
* subject = Reference(PcaPatient) 
* recordedDate = "2023-05-23T00:00:00+00:00"
* participant[0].actor = Reference(DrHause)
* participant[0].function = http://terminology.hl7.org/CodeSystem/provenance-participant-type#custodian "Custodian"
* participant[0].function.text = "Treating physician"
* stage.assessment[0] = Reference(PCacTStage) 
* stage.assessment[1] = Reference(PCaEAURisk) 
* stage.assessment[2] = Reference(PCaGleason) 
* stage.assessment[3] = Reference(PCaPSA2)

Instance: PCaStagingReport
InstanceOf: Bundle 
Usage: #example
Title: "Prostate Cancer Staging Report"
Description: "FHIR Document containing all resources related to the Prostate Cancer diagnosis for PCaPatient by Dr. Hause."
* type = #document 
* entry[+].resource = PCaStagingComposition
* entry[+].resource = PCacTStage
* entry[+].resource = PCaEAURisk
* entry[+].resource = PCaGleason
* entry[+].resource = PCaPSA1
* entry[+].resource = PCaPSA2
* entry[+].resource = RaisedPSACondition
* entry[+].resource = PCaCondition
* entry[+].resource = PCaPatient
* entry[+].resource = DrHause
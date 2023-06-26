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
* section[+]
  * title = "Medische voorgeschiedenis"
  * code.coding[0] = SCT#1003642006 "Past medical history section"
  * code.coding[+] = ReportSections#medical-history "Medical history section"
  * text.status = #generated
  * text.div = "<div>Hier volgt een leesbaar textoverzicht van de algemene medische voorgeschiedenis van de patiënt.</div>"
* section[+]
  * title = "Prostaat-gerateerde voorgeschiedenis"
  * code.coding[0] = SCT#422625006 "history of present illness section"
  * code.coding[+] = ReportSections#prostate-history "Prostate history section"
  * text.status = #generated
  * text.div = "<div>Hier volgt een leesbaar textoverzicht van de prostaat-gerelateerde medische voorgeschiedenis van de patiënt.</div>"
* section[+]
  * title = "Anamnese en klinisch onderzoek"
  * code = SCT#371529009 "History and physical report"
  * text.status = #generated
  * text.div = "<div>Hier volgt een leesbaar textoverzicht van de anamnese en het klinisch onderzoek van de patiënt.</div>"
* section[+]
  * title = "Technische onderzoeken"
  * code = SCT#4201000179104 "Imaging report"
  * text.status = #generated
  * text.div = "<div>Hier volgt een leesbaar textoverzicht van de technische onderzoeken van de patiënt.</div>"
* section[+]
  * title = "Staging prostaatkanker"
* section[+]
  * title = "Besluit bij verhoogde PSA"
  * code = SCT#722091001 "Conclusion interpretation document"
  * text.status = #generated
  * text.div = "<div>Hier volgt een leesbaar textoverzicht van het besluit bij verhoogde PSA van de patiënt.</div>"

Instance: PCacTStage
InstanceOf: Observation
Usage: #example
Title: "PCa T Stage"
Description: "Clinical T Stage observation of the prostate tumor."
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
Description: "EAU Risk Group observation of the prostate tumor."
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
* stage.assessment[+] = Reference(PCacTStage) 
* stage.assessment[+] = Reference(PCaEAURisk) 
* stage.assessment[+] = Reference(PCaGleason) 
* stage.assessment[+] = Reference(PCaPSA2) 

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

Profile: PCaMDT
Parent: EpisodeOfCare
Id: pca-mdt
Title: "PCaMDT"
Description: "Multi-disciplinary team (MDT) meeting for prostate cancer."
* status = #finished
* diagnosis
  * condition.reference = Reference(PCaCondition) 
  * use = http://hl7.org/fhir/encounter-diagnosis-use#final "Final"

Instance: PCaMDTResources
InstanceOf: GraphDefinition
Usage: #example
Title: "Prostate Cancer MDT"
Description: "Defines the set of resources to created during the MDT Prostate Cancer."
* name = "PCaMDT"
* status = #draft
* date = 2023-05-31
* node[0]
  * nodeId = "patient"
  * description = "The subject of the MDT"
  * type = #Patient
* node[1]
  * nodeId = "psa"
  * description = "PSA measurement of the patient"
  * type = #Observation
* node[2]
  * nodeId = "biopsy"
  * description = "Biopsy of the patient"
  * type = #DiagnosticReport
* link[0]
  * sourceId = "psa"
  * path = "subject"
  * targetId = "patient"
* link[1]
  * sourceId = "biopsy"
  * path = "subject"
  * targetId = "patient"
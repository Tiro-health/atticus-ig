Instance: Pneumologist
InstanceOf: Practitioner 
Usage: #example
Title: "Dr. Pneumologist"
Description: "Example medical doctor specialized in urology/oncology"

Instance: LCaPatient
InstanceOf: Patient
Usage: #example
Title: "Lung Cancer Patient"
Description: "Example patient that is diagnosed with lung cancer."
* identifier.value = "8242"
* identifier.system = "http://hospital.be/official-patient-id"
* gender = #male
* birthDate = "1973-04-06"

Instance: LCaStagingEncounter
InstanceOf: Encounter
Usage: #example
Title: "Lung Cancer Staging Encounter"
Description: "Example encounter where a patient has a lung cancer level."
* status = #in-progress
* subject = Reference(LCaPatient)

Instance: LCaStagingTemplate
InstanceOf: Questionnaire
Usage: #example
Title: "LCaStaging Template"
Description: "Questionnaire for Lung Cancer Staging."
* status = #active
* version = "5.0.1"
* language = #nl-BE
* insert QuestionnaireV3
* extension[Orientation].valueCode = #vertical
* item[0]
  * linkId = "diagnose"
  * type = #coding
  * text = "Diagnose"
  * code =  $SCT#439401001 "Diagnosis"
  * answerConstraint = #optionsOrType
  * answerValueSet = Canonical(LungCancerDiagnosis)
  * item[+] // DATE OF DIAGNOSIS
    * linkId = "diagnose/datum"
    * insert DateField
    * text = "Date of diagnosis"
    * code =  $SCT#432213005 "Date of diagnosis"
* item[+] // TNM
  * linkId = "ctnm"
  * type = #group
  * text = "cTNM"
  * code = $SCT#399566009 "TNM category"
  * item[+]
    * linkId = "t"
    * insert CodingDropdown
    * type = #coding
    * text = "cT"
    * code = $SCT#399504009 "cT category"
    * answerValueSet = Canonical(ClinicalTStageLungCancer) 
  * item[+]
    * linkId = "n"
    * insert CodingDropdown
    * type = #coding
    * text = "cN"
    * code = $SCT#399534004 "cN category"
    * answerValueSet = Canonical(ClinicalNStageLungCancer)
  * item[+]
    * linkId = "m"
    * insert CodingDropdown
    * type = #coding
    * text = "cM"
    * code = $SCT#399387003 "cM category"
    * answerValueSet = Canonical(ClinicalMStageLungCancer)
* item[+]
  * linkId = "metastasis-location"
  * type = #coding
  * insert CodingChips
  * text = "Location of metastasis"
  * code = $SCT#385421009 "Site of distant metastasis"
  * enableWhen[+] 
    * question = "ctnm/m"
    * operator = #=
    * answerCoding = $SCT#1229901006 "M0"
  * enableWhen[+]
    * question = "ctnm/m"
    * operator = #exists
    * answerBoolean = true
  * enableBehavior = #all
  * disabledDisplay = #hidden
  * answerValueSet = Canonical(LungCancerLocationOfMetastasis)
  * answerConstraint = #optionsOrType
* item[+]
  * linkId = "pd-l1"
  * type = #decimal
  * text = "PD-L1 expression"
  * code = $SCT#1255770005 "PD-L1 expression"
  * extension[$unit].valueCoding = $UCUM#%
// resourceId, path met linkId, "change",  ???
Instance: LCaStagingResponse
InstanceOf: QuestionnaireResponse
Usage: #example
Title: "LCaStagingResponse"
Description: "QuestionnaireResponse for Lung Cancer Staging."
* status = #completed
* subject = Reference(LCaPatient)
* author = Reference(DrHause)
* encounter = Reference(LCaStagingEncounter)
* questionnaire = Canonical(LCaStagingTemplate)
* authored = "2023-05-23T00:00:00+00:00"
* item[0]
  * linkId = "diagnose"
  * answer[0]
    * valueCoding = $SCT#254637007 "Non-small cell lung cancer"
    * extension[AnswerComment].valueAnnotation
      * text = "Some Comment"
    * item[+]
      * linkId = "diagnose/datum"
      * answer[0]
        * valueDate = "2023-05-23"
* item[+]
  * linkId = "ctnm"
  * item[+]
    * linkId = "t"
    * answer[0]
      * valueCoding = $SCT#1228938002 "T3"
  * item[+]
    * linkId = "n"
    * answer[0]
      * valueCoding = $SCT#1229973008 "N1"
  * item[+]
    * linkId = "m"
    * answer[0]
      * valueCoding = $SCT#1229903009 "M1"
* item[+]
  * linkId = "metastasis-location"
  * answer[0]
    * valueCoding = $SCT#94222008 "bony metastasis"
* item[+]
  * linkId = "pd-l1"
  * answer[0]
    * valueDecimal = 0.8

Instance: LCaStagingComposition
InstanceOf: Composition
Usage: #example
Title: "LCaStaging Composition"
Description: "Composition containing the Lung Cancer Staging Report."
* title = "Lung Cancer Staging Report"
* status = #final
* type.coding = $LOINC#18841-7 "Hospital consultation note"
* type.text = "Lung Cancer Staging Report"
* subject = Reference(LCaPatient)
* date = "2023-05-23T00:00:00+00:00"
* author = Reference(DrHause)
* encounter = Reference(LCaStagingEncounter)
* section[0]
  * title = "Staging"
  * text.div = "<div xmlns=\"http://www.w3.org/1999/xhtml\"><p>The patient was diagnosed with non-small cell lung cancer on 2023-05-23. The cTNM staging is T3N1M1. The patient has bony metastasis. The PD-L1 expression is 80%.</p></div>"
  * text.status = #generated
  * entry[+] = Reference(LCaStagingResponse)
  * entry[+] = Reference(CTStage)
  * entry[+] = Reference(CNStage)
  * entry[+] = Reference(CMStage)
  * entry[+] = Reference(PDL1Expression)
* section[+]
  * title = "Conclusion"
  * text.div = "<div xmlns=\"http://www.w3.org/1999/xhtml\"><p>Based on the results of the staging, the patient has a stage IV lung cancer.</p></div>"
  * text.status = #generated
  * entry[+] = Reference(TNMStageGroups)

Instance: LungCancerStaging
InstanceOf: Condition
Usage: #example
Title: "Lung Cancer Staging"
Description: "Lung Cancer Staging Condition."
* category[+] = http://terminology.hl7.org/CodeSystem/condition-category#problem-list-item "Problem List Item"
* code = $SCT#254637007 "Non-small cell lung cancer"
* clinicalStatus = #active
* subject = Reference(LCaPatient)


Instance: CTStage
InstanceOf: Observation
Usage: #example
Title: "CT Stage"
Description: "CT Stage Observation."
* status = #final
* code = $SCT#399504009 "cT category"
* subject = Reference(LCaPatient)
* performer = Reference(DrHause)
* effectiveDateTime = "2023-05-23T00:00:00+00:00"
* valueCodeableConcept = $SCT#1228938002 "T3"
* focus[+] = Reference(LungCancerStaging)

Instance: CNStage
InstanceOf: Observation
Usage: #example
Title: "CN Stage"
Description: "CN Stage Observation."
* status = #final
* code = $SCT#399534004 "cN category"
* subject = Reference(LCaPatient)
* performer = Reference(DrHause)
* effectiveDateTime = "2023-05-23T00:00:00+00:00"
* valueCodeableConcept = $SCT#1229973008 "N1"
* focus[+] = Reference(LungCancerStaging)
* performer = Reference(DrHause)

Instance: CMStage
InstanceOf: Observation
Usage: #example
Title: "CM Stage"
Description: "CM Stage Observation."
* status = #final
* code = $SCT#399387003 "cM category"
* subject = Reference(LCaPatient)
* performer = Reference(DrHause)
* effectiveDateTime = "2023-05-23T00:00:00+00:00"
* valueCodeableConcept = $SCT#1229903009 "M1"
* focus[+] = Reference(LungCancerStaging)
* performer = Reference(DrHause)

Instance: PDL1Expression
InstanceOf: Observation
Usage: #example
Title: "PD-L1 Expression"
Description: "PD-L1 Expression Observation."
* status = #final
* code.coding[+] = $SCT#1255770005 "Presence of PD-L1 in primary malignant neoplasm of lung by immunohistochemistry	"
* code.text = "PD-L1"
* subject = Reference(LCaPatient)
* performer = Reference(DrHause)
* effectiveDateTime = "2023-05-23T00:00:00+00:00"
* valueQuantity = 80 '%'
* focus[+] = Reference(LungCancerStaging)
* performer = Reference(DrHause)

Instance: TNMStageGroups
InstanceOf: Observation
Usage: #example
Title: "TNM Stage Group"
Description: "TNM Stage Group Observation."
* status = #final
* code = $SCT#399537006 "Clinical TNM stage grouping"
* subject = Reference(LCaPatient)
* effectiveDateTime = "2023-05-23T00:00:00+00:00"
* valueCodeableConcept = $SCT#1222843001 "Stage IV"
* performer = Reference(DrHause)
* method = $SCT#1269566009 "American Joint Commission on Cancer, Cancer Staging Manual, 9th version neoplasm staging system"
* hasMember[+] = Reference(CTStage)
* hasMember[+] = Reference(CNStage)
* hasMember[+] = Reference(CMStage)
* focus[+] = Reference(LungCancerStaging)

Instance: Metastasis
InstanceOf: Observation
Usage: #example
Title: "Metastasis"
Description: "Metastasis Observation."
* status = #final
* code = $SCT#94222008 "Cancer metastatic to bone"
* bodySite = $SCT#272673000 "Bone structure of skeleton"
* subject = Reference(LCaPatient)
* effectiveDateTime = "2023-05-23T00:00:00+00:00"
* performer = Reference(DrHause)

Instance: LCaStagingReportBundle
InstanceOf: Bundle
Usage: #example
Title: "Lung Cancer Staging Report"
Description: "Bundle containing the Lung Cancer Staging Report including the QuestionnaireResponse and related resources."
* type = #document
* entry[+]
  * resource = LCaStagingComposition
* entry[+]
  * resource = LCaStagingResponse
* entry[+]
  * resource = LCaStagingEncounter
* entry[+]
  * resource = LCaPatient
* entry[+]
  * resource = DrHause
* entry[+]
  * resource = LCaStagingTemplate
* entry[+]
  * resource = LungCancerStaging
* entry[+]  
  * resource = CTStage
* entry[+]
  * resource = CNStage
* entry[+]
  * resource = CMStage
* entry[+]
  * resource = PDL1Expression
* entry[+]
  * resource = TNMStageGroups
* entry[+]
  * resource = Metastasis



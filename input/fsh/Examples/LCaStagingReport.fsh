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
    * code = $SCT#277206009 "cN category"
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
  * code = $SCT#10828004 "PD-L1 expression"
  * extension[$unit].valueCoding = $UCUM#%
// resourceId, path met linkId, "change",  ???
Instance: LCaStagingResponse
InstanceOf: QuestionnaireResponse
Usage: #example
Title: "LCaStagingResponse"
Description: "QuestionnaireResponse for Lung Cancer Staging."
* status = #completed
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
      * valueCoding = $SCT#T1 "T3"
  * item[+]
    * linkId = "n"
    * answer[0]
      * valueCoding = $SCT#N0 "N1"
  * item[+]
    * linkId = "m"
    * answer[0]
      * valueCoding = $SCT#M0 "M1"
* item[+]
  * linkId = "metastasis-location"
  * answer[0]
    * valueCoding = $SCT#94222008 "bony metastasis"
* item[+]
  * linkId = "pd-l1"
  * answer[0]
    * valueDecimal = 0.8
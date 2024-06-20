
Instance: BloodPressureFormated
InstanceOf: Questionnaire
Usage: #example
Title: "Blood Pressure (formatted input)"
Description: "Text field for Blood Pressure which decomposes automatically into Systolic and Diastolic components"
* status = #active
* version = "1.0.0"
* item[+]
  * linkId = "blood-pressure"
  * text = "Blood Pressure"
  * type = #string
  * extension[InputGroupSeparator].valueString = "/"
  * extension[$entryFormat].valueString = ".. / .."
  * extension[Regex].valueString = "^[0-9]{1,3} / [0-9]{1,3}$"
  * item[+]
    * linkId = "systolic"
    * text = "Systolic"
    * type = #integer
    * extension[$minValue].valueInteger = 0
    * extension[$maxValue].valueInteger = 300
    * extension[$calculated].valueExpression
      * language = #text/fhirpath
      * expression = "%resource.item.where(linkId='blood-pressure').answer.value.split(' / ')[0].toInteger()"
  * item[+]
    * linkId = "diastolic"
    * text = "Diastolic"
    * type = #integer
    * extension[$minValue].valueInteger = 0
    * extension[$maxValue].valueInteger = 300
    * extension[$calculated].valueExpression
      * language = #text/fhirpath
      * expression = "%resource.item.where(linkId='blood-pressure').answer.value.split(' / ')[1].toInteger()"

Instance: BloodPressureInputGroup
InstanceOf: Questionnaire
Usage: #example
Title: "Blood Pressure (grouped input)"
Description: "Blood Pressure with Systolic and Diastolic components"
* status = #active
* version = "1.0.0"
* item[+]
  * linkId = "blood-pressure"
  * text = "Blood Pressure"
  * type = #group
  * item[+]
    * linkId = "systolic"
    * text = "Systolic"
    * type = #integer
    * extension[$minValue].valueInteger = 0
    * extension[$maxValue].valueInteger = 300
  * item[+]
    * linkId = "diastolic"
    * text = "Diastolic"
    * type = #integer
    * extension[$minValue].valueInteger = 0
    * extension[$maxValue].valueInteger = 300


Instance: DateOfDiagnosis 
InstanceOf: Questionnaire
Usage: #example
Title: "Diagnose datum"
Description: "Datum waarop de diagnose is gesteld."
* insert LibraryItem
* status = #active
* version = "1.0.0"
* date = 2024-06-20
* publisher = "Tiro.health"
* item[+]
  * linkId = "diagnosis-date"
  * text = "Incidentiedatum"
  * type = #date
  * code = $SCT#432213005 "Date of Diagnosis"
  * insert DateTextbox
  * extension[$entryFormat].valueString = "YYYY-MM-DD"
  * extension[Regex].valueString = "^[0-9]{4}-[0-9]{2}-[0-9]{2}$"

// Clinical TNM Stage for Lung Cancer

ValueSet: ClinicalTStageLungCancer
Id: clinical-tstage-lung-cancer
Title: "Clinical TStage Lung Cancer"
Description: "AJCC 8th Edition Clinical TStage for Lung Cancer"
* ^status = #active
* $SCT#1222604002 "Tx"
* $SCT#1228882005 "T0"
* $SCT#1228884006 "Tis"
* $SCT#1228889001 "T1"
* $SCT#1228891009 "T1mi"
* $SCT#1228892002 "T1a"
* $SCT#1228895000 "T1b"
* $SCT#1228899006 "T1c"
* $SCT#1228929004 "T2"
* $SCT#1228931008 "T2a"
* $SCT#1228934000 "T2b"
* $SCT#1228938002 "T3"
* $SCT#1228944003 "T4"

ValueSet: ClinicalNStageLungCancer
Id: clinical-nstage-lung-cancer
Title: "Clinical NStage Lung Cancer"
Description: "AJCC 8th Edition Clinical NStage for Lung Cancer"
* ^status = #active
* $SCT#1229966003 "Nx"
* $SCT#1229967007 "N0"
* $SCT#1229973008 "N1"
* $SCT#1229978004 "N2"
* $SCT#1229981009 "N2a"
* $SCT#1229982002 "N2b"
* $SCT#1229984001 "N3"

ValueSet: ClinicalMStageLungCancer
Id: clinical-mstage-lung-cancer
Title: "Clinical MStage Lung Cancer"
Description: "AJCC 8th Edition Clinical MStage for Lung Cancer"
* ^status = #active
* $SCT#1229901006 "M0"
* $SCT#1229903009 "M1"
* $SCT#1229904003 "M1a"
* $SCT#1229907005 "M1b"
* $SCT#1229910003 "M1c"


Instance: ClinicalTNMStage
InstanceOf: Questionnaire
Usage: #example
Title: "Clinical TNM Stage"
Description: "Clinical TNM Stage"
* status = #active
* item[+]
  * linkId = "clinical-tnm-stage"
  * text = "Clinical TNM Stage"
  * code = $SCT#258219007 "TNM classification of malignant tumor before any treatment"
  * type = #group
  * item[+]
    * linkId = "t-stage"
    * text = "T Stage"
    * code = $SCT#399504009 "cT category"
    * type = #coding
    * answerValueSet = Canonical(ClinicalTStageLungCancer)
  * item[+]
    * linkId = "n-stage"
    * text = "N Stage"
    * code = $SCT#399534004 "cN category"
    * type = #coding
    * answerValueSet = Canonical(ClinicalNStageLungCancer)
  * item[+]
    * linkId = "m-stage"
    * text = "M Stage"
    * code = $SCT#399387003 "cM category"
    * type = #coding
    * answerValueSet = Canonical(ClinicalMStageLungCancer)


Instance: InputComponentLibrary
InstanceOf: Bundle
Usage: #example
Title: "Input Component Library"
Description: "Library of reusable input controls and input groups for FHIR Questionnaire items"
* type = #searchset
* entry[+]
  * resource = BloodPressureFormated
* entry[+]
  * resource = BloodPressureInputGroup
* entry[+]
  * resource = DateOfDiagnosis
* entry[+]
  * resource = ClinicalTNMStage

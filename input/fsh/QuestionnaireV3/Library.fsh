
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
* title = "Diagnose datum"
* description = "Datum waarop de diagnose is gesteld."
* id = "6482fabe"
* url = "http://content.tiro.health/library/6482fabe"
* insert LibraryItem
* status = #active
* language = #nl-BE
* version = "1.0.0"
* item[+]
  * linkId = "diagnosis-date"
  * text = "Incidentiedatum"
  * code = $SCT#432213005 "Date of diagnosis"
  * insert DateField
  * extension[+]
    * url = $entryFormat
    * valueString = "YYYY-MM-DD"
  * extension[+]
    * url = "http://fhir.tiro.health/StructureDefinition/regex"
    * valueString = "^[0-9]{4}-[0-9]{2}-[0-9]{2}$"

ValueSet: WHOScore
Id: who-score
Title: "WHO Score"
Description: "SNOMED-CT bevindingen functioneringsniveau volgens Wereldgezondheidsorganisatie"
* ^experimental = false
* include codes from system $SCT where concept is-a #373802001 "WHO performance status finding"

Instance: WHOScoreDropdown
InstanceOf: Questionnaire
Usage: #example
Title: "WHO Score"
Description: "Functioneringsniveau volgens Wereldgezondheidsorganisatie"
* title = "WHO Score"
* language = #nl-BE
* description = "Functioneringsniveau volgens Wereldgezondheidsorganisatie"
* id = "f8538c7a"
* url = "http://content.tiro.health/library/f8538c7a"
* insert LibraryItem
* status = #active
* version = "1.0.0"
* item[+]
  * linkId = "who-score"
  * text = "WHO Score"
  * insert CodingDropdown
  * answerValueSet = Canonical(WHOScore)

Instance: SmokingStatus
InstanceOf: Questionnaire
Usage: #example
Title: "Smoking Status"
Description: "Smoking Status"
* id = "ec49bd25"
* url = "http://content.tiro.health/library/ec49bd25"
* title = "Rookstatus"
* description = "Rookstatus van de patiënt opgedeeld in drie categorieën: nooit gerookt, ex-roker en actieve roker."
* language = #nl-BE
* status = #active
* item[+]
  * linkId = "smoking-status"
  * insert CodingChips
  * text = "Smoking Status"
  * code = $SCT#229819007 "Tobacco use and exposure"
  * answerOption[+]
    * valueCoding = $SCT#266919005 "Never smoked"
  * answerOption[+]
    * valueCoding = $SCT#8517006 "Former smoker"
  * answerOption[+]
    * valueCoding = $SCT#77176002 "Smoker"



// Clinical TNM Stage for Lung Cancer

ValueSet: ClinicalTStageLungCancer
Id: clinical-tstage-lung-cancer
Title: "Clinical TStage Lung Cancer"
Description: "AJCC 8th Edition Clinical TStage for Lung Cancer"
* ^status = #active
* ^experimental = false
* $SCT#1222604002 "Tx"
* $SCT#1228882005 "T0"
* $SCT#1228884006 "American Joint Committee on Cancer cTis"
* $SCT#1228889001 "American Joint Committee on Cancer cT1"
* $SCT#1228891009 "American Joint Committee on Cancer cT1mi"
* $SCT#1228892002 "American Joint Committee on Cancer cT1a"
* $SCT#1228895000 "American Joint Committee on Cancer cT1b"
* $SCT#1228899006 "American Joint Committee on Cancer cT1c"
* $SCT#1228929004 "American Joint Committee on Cancer cT2"
* $SCT#1228931008 "American Joint Committee on Cancer cT2a"
* $SCT#1228934000 "American Joint Committee on Cancer cT2b"
* $SCT#1228938002 "cT3"
* $SCT#1228944003 "T4"

ValueSet: ClinicalNStageLungCancer
Id: clinical-nstage-lung-cancer
Title: "Clinical NStage Lung Cancer"
Description: "AJCC 8th Edition Clinical NStage for Lung Cancer"
* ^status = #active
* ^experimental = false
* $SCT#1229966003 "Nx"
* $SCT#1229967007 "N0"
* $SCT#1229973008 "cN1"
* $SCT#1229978004 "N2"
* $SCT#1229981009 "American Joint Committee on Cancer cN2a"
* $SCT#1229982002 "American Joint Committee on Cancer cN2b"
* $SCT#1229984001 "American Joint Committee on Cancer cN3"

ValueSet: ClinicalMStageLungCancer
Id: clinical-mstage-lung-cancer
Title: "Clinical MStage Lung Cancer"
Description: "AJCC 8th Edition Clinical MStage for Lung Cancer"
* ^status = #active
* ^experimental = false
* $SCT#1229901006 "American Joint Committee on Cancer cM0"
* $SCT#1229903009 "American Joint Committee on Cancer cM1"
* $SCT#1229904003 "American Joint Committee on Cancer cM1a"
* $SCT#1229907005 "American Joint Committee on Cancer cM1b"
* $SCT#1229910003 "American Joint Committee on Cancer cM1c"


Instance: ClinicalTNMStage
InstanceOf: Questionnaire
Usage: #example
Title: "Clinical TNM Stage"
Description: "Clinical TNM Stage"
* status = #active
* item[+]
  * linkId = "clinical-tnm-stage"
  * text = "Clinical TNM Stage"
  * code = $SCT#258219007 "Stage 2"
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
* link.relation = #self
* link.url = "http://fhir.tiro.health/Questionnaire?_tag=library-item"
* entry[+]
  * fullUrl = "http://fhir.tiro.health/Questionnaire/BloodPressureFormated"
  * resource = BloodPressureFormated
* entry[+]
  * fullUrl = "http://fhir.tiro.health/Questionnaire/BloodPressureInputGroup"
  * resource = BloodPressureInputGroup
* entry[+]
  * fullUrl = "http://fhir.tiro.health/Questionnaire/6482fabe"
  * resource = DateOfDiagnosis
* entry[+]
  * fullUrl = "http://fhir.tiro.health/Questionnaire/ClinicalTNMStage"
  * resource = ClinicalTNMStage

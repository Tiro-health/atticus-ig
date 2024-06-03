Profile: Report
Parent: Bundle
Id: Report
Title: "Report"
Description: "FHIR Document Bundle with a Composition and a list of resources that describe the clinical report."
* type = #document 

RuleSet: BlockReference(linkId, canonical)
* item[+]
  * linkId = "{linkId}"
  * type = #group
  * extension[$variable].valueExpression
    * name = #linkIdPrefix
    * language = #text/fhirpath
    * expression = "{linkId}/"
  * item[0]
    * linkId = "{linId}/reference"
    * type = #display
    * extension[$subQuestionnaire]
      * valueCanonical = "{canonical}"

Instance: ReportTemplate
InstanceOf: Questionnaire
Usage: #example
Title: "Example Report Template"
Description: "Report Template represented as FHIR Questionnaire with references to sub-questionnaires that represent building blocks of the report."
* status = #active
* insert BlockReference(klinisch-onderzoek, http://fhir.tiro.health/Block/klinisch-onderzoek|1.0.0)
* insert BlockReference(ecg, http://fhir.tiro.health/Block/electrocardiogram|1.0.0)

Instance: PopulationRequest
InstanceOf: Parameters
Usage: #example
Title: "Population Request"
Description: "Request for a population of patients."
* parameter[+]
  * name = "questionnaire"
  * resource = ReportTemplate
* parameter[+]
  * name = "subject"
  * valueReference = Reference(Patient)
* parameter[+]
  * name = "encounter"
  * valueReference = Reference(Encounter)
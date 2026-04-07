Alias: $initialExpression = http://hl7.org/fhir/uv/sdc/StructureDefinition/sdc-questionnaire-initialExpression
Alias: $calculatedExpression = http://hl7.org/fhir/uv/sdc/StructureDefinition/sdc-questionnaire-calculatedExpression
Alias: $candidateExpression = http://hl7.org/fhir/uv/sdc/StructureDefinition/sdc-questionnaire-candidateExpression
Alias: $answerExpression = http://hl7.org/fhir/uv/sdc/StructureDefinition/sdc-questionnaire-answerExpression
Alias: $itemPopulationContext = http://hl7.org/fhir/uv/sdc/StructureDefinition/sdc-questionnaire-itemPopulationContext
Alias: $contextExpression = http://hl7.org/fhir/uv/sdc/StructureDefinition/sdc-questionnaire-contextExpression
Alias: $launchContext = http://hl7.org/fhir/uv/sdc/StructureDefinition/sdc-questionnaire-launchContext
Alias: $variable = http://hl7.org/fhir/StructureDefinition/variable

// =============================================================================
// Population & Calculation Capabilities
// =============================================================================
// Tiro.health supports the following SDC (Structured Data Capture) population
// and calculation mechanisms for FHIR Questionnaires:
//
// 1. Pre-population (initialExpression)
//    - FHIRPath expressions evaluated at form launch to pre-fill answers
//    - Supports template variables: %patient, %encounter, %user
//
// 2. Calculated values (calculatedExpression)
//    - FHIRPath expressions that dynamically compute values from other answers
//    - Re-evaluated whenever referenced answers change
//
// 3. Candidate search (candidateExpression)
//    - x-fhir-query expressions to search for candidate resources
//    - Used for populating repeating groups from FHIR data
//    - Supports template variable interpolation: {{%patient.id}}
//
// 4. Dynamic answer options (answerExpression)
//    - x-fhir-query expressions that populate answer options dynamically
//    - Used when options depend on external data or other answers
//
// 5. Population context (itemPopulationContext)
//    - Defines a variable scope for populating repeating group instances
//    - Each instance of the repeating group gets a context variable
//
// 6. Context expressions (contextExpression)
//    - Labeled x-fhir-query expressions for contextual guidance
//    - Provides additional data context without directly populating answers
//
// 7. Variables (variable)
//    - Named FHIRPath or x-fhir-query expressions at questionnaire or item level
//    - Referenced by other expressions using %variableName syntax
//
// 8. Launch context (launchContext)
//    - Defines expected context resources at questionnaire launch
//    - Standard contexts: patient, encounter, user, practitioner
//
// Population modes supported:
//   - pre-populate: Initial population at form launch
//   - re-populate: Re-run population on an existing response
//   - contextual-populate: Populate with additional context data
// =============================================================================


// --- Example: Pre-populated Patient Demographics ---

Instance: PrePopulatedDemographics
InstanceOf: TiroQuestionnaire
Usage: #example
Title: "Pre-populated Patient Demographics"
Description: "Example questionnaire demonstrating pre-population of patient data using FHIRPath expressions and variables."
* insert QuestionnaireV3
* url = "http://example.tiro.health/Questionnaire/pre-populated-demographics"
* status = #draft
* name = "PrePopulatedDemographics"
* title = "Patient Demographics (Pre-populated)"
* subjectType = #Patient

// Launch context: patient
* extension[$launchContext]
  * extension[name].valueCoding = http://hl7.org/fhir/uv/sdc/CodeSystem/launchContext#patient "Patient"
  * extension[type].valueCode = #Patient

// Questionnaire-level variable
* extension[$variable]
  * valueExpression
    * name = #patient
    * language = #text/fhirpath
    * expression = "%resource.subject.resolve()"

* item[+]
  * linkId = "patient-name"
  * text = "Patient Name"
  * type = #string
  * extension[$initialExpression]
    * valueExpression
      * language = #text/fhirpath
      * expression = "%patient.name.first().text"

* item[+]
  * linkId = "patient-birthdate"
  * text = "Date of Birth"
  * type = #date
  * extension[$initialExpression]
    * valueExpression
      * language = #text/fhirpath
      * expression = "%patient.birthDate"


// --- Example: Calculated BMI ---

Instance: CalculatedBMI
InstanceOf: TiroQuestionnaire
Usage: #example
Title: "Calculated BMI"
Description: "Example questionnaire demonstrating calculated expressions for automatic BMI computation."
* insert QuestionnaireV3
* url = "http://example.tiro.health/Questionnaire/calculated-bmi"
* status = #draft
* name = "CalculatedBMI"
* title = "BMI Calculator"
* subjectType = #Patient

* item[+]
  * linkId = "weight"
  * text = "Weight"
  * insert DecimalTextbox(#kg)
  * extension[$minValue].valueDecimal = 0
  * extension[$maxValue].valueDecimal = 500

* item[+]
  * linkId = "height"
  * text = "Height"
  * insert DecimalTextbox(#cm)
  * extension[$minValue].valueDecimal = 0
  * extension[$maxValue].valueDecimal = 300

* item[+]
  * linkId = "bmi"
  * text = "BMI"
  * insert DecimalTextbox(#kg/m2)
  * readOnly = true
  * extension[$calculatedExpression]
    * valueExpression
      * language = #text/fhirpath
      * expression = "(%resource.item.where(linkId='weight').answer.value / (%resource.item.where(linkId='height').answer.value * 0.01).power(2)).round(1)"


// --- Example: Dynamic Answer Options via x-fhir-query ---

Instance: DynamicPractitionerLookup
InstanceOf: TiroQuestionnaire
Usage: #example
Title: "Dynamic Practitioner Lookup"
Description: "Example questionnaire demonstrating dynamic answer options populated from a FHIR server using x-fhir-query."
* insert QuestionnaireV3
* url = "http://example.tiro.health/Questionnaire/dynamic-practitioner-lookup"
* status = #draft
* name = "DynamicPractitionerLookup"
* title = "Referring Practitioner"
* subjectType = #Patient

* extension[$launchContext]
  * extension[name].valueCoding = http://hl7.org/fhir/uv/sdc/CodeSystem/launchContext#patient "Patient"
  * extension[type].valueCode = #Patient

* item[+]
  * linkId = "referring-practitioner"
  * text = "Referring Practitioner"
  * type = #reference
  * extension[$answerExpression]
    * valueExpression
      * language = #application/x-fhir-query
      * expression = "PractitionerRole?active=true&_include=PractitionerRole:practitioner"

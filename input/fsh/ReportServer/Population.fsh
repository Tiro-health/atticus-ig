// =============================================================================
// $populate Operation — Population Modes and Provenance Output
// =============================================================================
// The Tiro $populate operation extends the SDC Questionnaire/$populate
// operation with three population modes and a provenance output parameter.
//
// Population modes (parameter name="mode"):
//   pre-populate        — Evaluate initialExpression / item.initial at form launch.
//   re-populate         — Re-run population on an existing QuestionnaireResponse.
//   contextual-populate — AI-driven extraction from clinical document context.
//
// Contextual-populate specifics:
//   Accepts a context parameter with name="clinical-artifacts" containing one or
//   more DocumentReference resources (base64-encoded HTML or PDF attachments).
//   The AI marking pipeline processes up to 5 documents in parallel, labels HTML
//   spans, and extracts answer values per questionnaire item.
//
// Provenance output:
//   The response Parameters includes one parameter[name="provenance"] entry per
//   populated field, each carrying a FormProvenance resource.
//   Each Provenance links to its field via:
//     target[0].reference = "#"                       (the QuestionnaireResponse)
//     target[0].extension[targetElement].valueUri     (QuestionnaireResponse.item.id — a UUID)
//   For AI clipboard: entity.what references the source DocumentReference, and
//   entity.what.extension[html-element-id] carries the labeled span IDs that
//   support source-highlighting in the UI.
// =============================================================================


Instance: TiroPopulate
InstanceOf: OperationDefinition
Usage: #definition
Title: "Tiro Questionnaire $populate"
Description: "Populate a Questionnaire with pre-existing data or AI-extracted values from clinical documents. Extends SDC Questionnaire/$populate with the contextual-populate mode and a provenance output parameter."
* name = "TiroPopulate"
* status = #active
* kind = #operation
* code = #populate
* resource[+] = #Questionnaire
* system = false
* type = true
* instance = true
* parameter[+]
  * name = #questionnaire
  * use = #in
  * min = 0
  * max = "1"
  * type = #canonical
  * documentation = "Canonical URL (optionally versioned) of the Questionnaire to populate. If the operation is invoked on a Questionnaire instance, this parameter is optional."
* parameter[+]
  * name = #subject
  * use = #in
  * min = 0
  * max = "1"
  * type = #Reference
  * documentation = "Patient resource or reference used as the population subject."
* parameter[+]
  * name = #mode
  * use = #in
  * min = 0
  * max = "1"
  * type = #string
  * documentation = "Population mode: pre-populate | re-populate | contextual-populate. Defaults to pre-populate."
* parameter[+]
  * name = #context
  * use = #in
  * min = 0
  * max = "*"
  * documentation = "Named context groups providing data for population. For contextual-populate, include a group with name='clinical-artifacts'."
  * part[+]
    * name = #name
    * use = #in
    * min = 1
    * max = "1"
    * type = #string
    * documentation = "Context group name (e.g. 'clinical-artifacts')."
  * part[+]
    * name = #content
    * use = #in
    * min = 0
    * max = "*"
    * type = #Reference
    * documentation = "Content resource for this context group (e.g. a DocumentReference with an HTML or PDF attachment)."
* parameter[+]
  * name = #responseCandidate
  * use = #in
  * min = 0
  * max = "1"
  * type = #QuestionnaireResponse
  * documentation = "Existing QuestionnaireResponse used as the base for re-populate mode."
* parameter[+]
  * name = #response
  * use = #out
  * min = 1
  * max = "1"
  * type = #QuestionnaireResponse
  * documentation = "The populated QuestionnaireResponse."
* parameter[+]
  * name = #issues
  * use = #out
  * min = 0
  * max = "1"
  * type = #OperationOutcome
  * documentation = "Issues encountered during population (warnings, errors)."
* parameter[+]
  * name = #provenance
  * use = #out
  * min = 0
  * max = "*"
  * type = #Provenance
  * documentation = "One FormProvenance per populated field, describing how the value was obtained. Repeated — one entry per item. Each Provenance.target[0].extension[targetElement].valueUri points to the QuestionnaireResponse.item.id of the populated field."


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
    * linkId = "{linkId}/reference"
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
Title: "Population Request (pre-populate)"
Description: "Example pre-populate request: evaluates initialExpression and item.initial at form launch."
* parameter[+]
  * name = "questionnaire"
  * resource = ReportTemplate
* parameter[+]
  * name = "subject"
  * valueReference = Reference(LCaPatient)
* parameter[+]
  * name = "encounter"
  * valueReference = Reference(LCaStagingEncounter)


// -----------------------------------------------------------------------------
// Contextual-populate example
// Shows the request Parameters and a representative response Parameters
// with one QuestionnaireResponse and one FormProvenance entry.
// -----------------------------------------------------------------------------

Instance: ContextualPopulateRequest
InstanceOf: Parameters
Usage: #example
Title: "Contextual Populate Request"
Description: "Example contextual-populate request supplying a clinical DocumentReference as AI context. The AI marking pipeline extracts field values and returns one FormProvenance per populated item."
* parameter[+]
  * name = "questionnaire"
  * valueCanonical = "http://fhir.tiro.health/Questionnaire/lca-staging|1.2.0"
* parameter[+]
  * name = "subject"
  * valueReference.reference = "Patient/patient-123"
  * valueReference.display = "Jan Janssen"
* parameter[+]
  * name = "mode"
  * valueString = "contextual-populate"
* parameter[+]
  * name = "context"
  * part[+]
    * name = "name"
    * valueString = "clinical-artifacts"
  * part[+]
    * name = "content"
    * valueReference.reference = "DocumentReference/doc-001"
    * valueReference.display = "Referral letter from AZ Monica"


Instance: ContextualPopulateResponse
InstanceOf: Parameters
Usage: #example
Title: "Contextual Populate Response"
Description: "Example $populate response for contextual-populate mode. Includes the populated QuestionnaireResponse and one FormProvenance entry per populated field. In practice, provenance is repeated once per field."
* parameter[+]
  * name = "response"
  * resource = qr-123
// One provenance parameter per populated field (repeated):
* parameter[+]
  * name = "provenance"
  * resource = prov-002
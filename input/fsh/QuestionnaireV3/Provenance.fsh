// =============================================================================
// Form Provenance — CodeSystems, Extensions, Profile, and Examples
// =============================================================================
// Every field populated by the Atticus $populate operation receives a
// FormProvenance resource describing how the value was obtained. Provenances
// are returned as repeated parameter[name="provenance"] entries in the
// $populate response Parameters (one per populated field).
//
// Agent codes:
//   All automated Atticus engines use provenance-participant-type#assembler
//   Source document authors use provenance-participant-type#author
//
// Note: the legacy AgentTypes CodeSystem below is retired; existing persisted
// Provenance resources may still reference those codes.
// =============================================================================


// -----------------------------------------------------------------------------
// FormActivity CodeSystem
// -----------------------------------------------------------------------------
// When dual-coding is needed (e.g. initial-expression + data-import), both
// codes are included in activity.coding with system=form-activity.
// -----------------------------------------------------------------------------

CodeSystem: FormActivity
Id: form-activity
Title: "Form Activity"
Description: "Activities that can be performed on form fields and which will be tracked through provenance"
* ^experimental = false
* ^caseSensitive = true
* #user "User input" "Manually entered data by the user"
* #manual "Manual input" "Manually entered data by the user without additional system assistance"
* #static "Static value" "A preconfigured value that has been set without active user choice"
  * #preset "Preset" "Populated by a saved preset configuration"
  * #initial-value "Initial value" "Populated by Questionnaire.item.initial"
* #calculation "Calculation" "A value computed from a FHIRPath calculatedExpression"
  * #fhirpath "FHIRPath calculation" "Deprecated — use #calculation for calculatedExpression or #initial-expression for initialExpression"
* #ai "AI population" "An AI algorithm generated or extracted the value"
  * #speech-population "Speech-based population" "A speech-to-text solution populated the field"
  * #ai-clipboard "AI Clipboard" "An AI engine extracted the value from clinical document content"
* #data-import "Data Import" "Import of values from FHIR resources or external data sources"
  * #initial-expression "Initial expression" "Populated by evaluating Questionnaire.item.initialExpression against launch context or server data"
  * #definition "Definition-based import" "Populated by matching Questionnaire.item.definition to a FHIR resource element"
* #submit "Submit" "Form has been submitted for review or final processing"
* #amend "Amend" "Form has been amended or updated after initial submission"


// -----------------------------------------------------------------------------
// AgentTypes CodeSystem — RETIRED
// Replaced by http://terminology.hl7.org/CodeSystem/provenance-participant-type
// Kept for backward-compatibility with persisted Provenance resources.
// -----------------------------------------------------------------------------

CodeSystem: AgentTypes
Id: agent-types
Title: "Agent Types (Retired)"
Description: "Retired. Agent type codes previously used in Provenance.agent.type. Use http://terminology.hl7.org/CodeSystem/provenance-participant-type (code: assembler) instead."
* ^experimental = false
* ^status = #retired
* ^caseSensitive = true
* #fhirpath-engine "FHIRPath Engine" "FHIRPath expression engine"
* #population-engine "Population Engine" "Engine that populates forms from external data sources"
* #preset-engine "Preset Engine" "Engine that applies preset configurations"
* #x-fhir-query-resolver "X-FHIR Query Resolver" "Resolves x-fhir-query extensions"


// -----------------------------------------------------------------------------
// ValueSets
// -----------------------------------------------------------------------------

ValueSet: FormActivityVS
Id: form-activity-vs
Title: "Form Activity ValueSet"
Description: "Activities that can be performed on form fields"
* ^experimental = false
* include codes from system FormActivity


ValueSet: AgentTypesVS
Id: agent-types-vs
Title: "Agent Types ValueSet (Retired)"
Description: "Retired. Use ProvenanceAgentTypeVS instead."
* ^experimental = false
* ^status = #retired
* include codes from system AgentTypes


ValueSet: ProvenanceAgentTypeVS
Id: provenance-agent-type-vs
Title: "Provenance Agent Type Value Set"
Description: "Standard FHIR agent type codes used in FormProvenance.agent.type. Automated Atticus engines use #assembler; source document authors use #author."
* ^experimental = false
* http://terminology.hl7.org/CodeSystem/provenance-participant-type#assembler "Assembler"
* http://terminology.hl7.org/CodeSystem/provenance-participant-type#author "Author"


// -----------------------------------------------------------------------------
// Extensions
// -----------------------------------------------------------------------------

Extension: ProvenanceWhy
Id: provenance-why
Title: "Provenance Why (R6 Pre-adopt)"
Description: "Pre-adoption of R6 Provenance.why — describes why the event recorded in this provenance occurred in textual form. For AI-populated fields this captures the model's reasoning. Note: the backend currently stores reasoning in activity.text; ProvenanceWhy is the intended field going forward."
Context: Provenance
* value[x] only markdown


Extension: HtmlElementId
Id: html-element-id
Title: "HTML Element ID"
Description: "ID of a labeled HTML element (e.g. a span with a data-label attribute) within a DocumentReference attachment that the AI used as source text when extracting a field value. Multiple occurrences indicate multiple contributing spans. Enables UI source-highlighting."
Context: Provenance.entity.what
* value[x] only string


// -----------------------------------------------------------------------------
// Device instances — Atticus engine agents
// Used as Provenance.agent.who for automated population.
// Note: the backend uses integer Device IDs (Device/1 through Device/5);
// these IG instances use descriptive IDs for readability.
// -----------------------------------------------------------------------------

Instance: atticus-fhirpath-engine
InstanceOf: Device
Usage: #example
Title: "Atticus FHIRPath Engine"
Description: "FHIRPath expression evaluation engine. Referenced as Provenance.agent.who when initialExpression or calculatedExpression is evaluated. Backend reference: Device/1."
* displayName = "Atticus FHIRPath Engine"

Instance: atticus-population-engine
InstanceOf: Device
Usage: #example
Title: "Atticus Population Engine"
Description: "Population engine that applies initial values, evaluates definitions, and handles repopulation. Backend reference: Device/2."
* displayName = "Atticus Population Engine"

Instance: atticus-preset-engine
InstanceOf: Device
Usage: #example
Title: "Atticus Preset Engine"
Description: "Preset engine that loads saved preset configurations onto form fields. Backend reference: Device/3."
* displayName = "Atticus Preset Engine"

Instance: atticus-ai-marking-engine
InstanceOf: Device
Usage: #example
Title: "Atticus AI Marking Engine"
Description: "AI engine that labels and marks clinical document HTML content for extraction. Backend reference: Device/4."
* displayName = "Atticus AI Marking Engine"

Instance: atticus-ai-population-engine
InstanceOf: Device
Usage: #example
Title: "Atticus AI Population Engine"
Description: "AI engine that extracts answer values from labeled clinical document content (contextual-populate). Backend reference: Device/5."
* displayName = "Atticus AI Population Engine"


// -----------------------------------------------------------------------------
// FormProvenance Profile
// -----------------------------------------------------------------------------

Profile: FormProvenance
Parent: Provenance
Id: form-provenance
Title: "Form Provenance"
Description: "Profile for tracking the origin and method of data entry for form fields to support audit trails and transparency. One FormProvenance resource is created per populated QuestionnaireResponse item."
* ^purpose = "Track the origin and method of data entry for form fields to support audit trails and transparency"

// Why (R6 pre-adopt): AI reasoning / rationale.
// Current backend state: reasoning is stored in activity.text (plain string).
// ProvenanceWhy (markdown) is the intended field going forward.
* extension contains ProvenanceWhy named why 0..1 MS
* extension[why] ^short = "AI reasoning or rationale for the activity (R6 pre-adopt)"
* extension[why] ^definition = "Textual explanation of why the recorded event occurred. For AI-populated fields, this captures the model's reasoning. Backend currently uses activity.text; this extension is the intended long-term location."

// Target: always the enclosing QuestionnaireResponse, with targetElement pointing
// to the specific item.id (a server-assigned UUID, not item.linkId).
* target 1..* MS
* target only Reference(QuestionnaireResponse)
* target.extension contains http://hl7.org/fhir/StructureDefinition/targetElement named targetElement 1..1 MS
* target.extension[targetElement] ^short = "Specific item within the QuestionnaireResponse"
* target.extension[targetElement] ^definition = "Points to a specific QuestionnaireResponse.item.id (a server-assigned UUID) within the referenced QuestionnaireResponse. Note: this is item.id, not item.linkId."

// Activity: at least one Tiro form-activity code required.
// For activities with a more specific child code (e.g. #definition), the backend
// also includes the parent code (#data-import) as a second tiroActivity coding.
* activity 1..1 MS
* activity.coding 1..* MS
* activity.coding ^slicing.discriminator.type = #pattern
* activity.coding ^slicing.discriminator.path = "system"
* activity.coding ^slicing.rules = #open
* activity.coding ^slicing.description = "Slicing based on the code system"
* activity.coding contains
    tiroActivity 1..* MS and
    isoLifecycle 0..1 MS
* activity.coding[tiroActivity].system = "http://fhir.tiro.health/CodeSystem/form-activity"
* activity.coding[tiroActivity] from FormActivityVS (required)
* activity.coding[tiroActivity] ^short = "Activity that was performed on the form field"
* activity.coding[tiroActivity] ^definition = "One or more Tiro-defined activity codes. When a specific child code is used (e.g. #definition), the parent code (#data-import) is also included."
* activity.coding[isoLifecycle].system = "http://terminology.hl7.org/CodeSystem/iso-21089-lifecycle"
* activity.coding[isoLifecycle] ^short = "ISO 21089 lifecycle event"
* activity.coding[isoLifecycle] ^definition = "Optional standard ISO 21089 lifecycle event corresponding to the activity. Typically #originate for initial population."

// Recorded timestamp is required
* recorded 1..1 MS

// Agent: the automated system or user that performed the activity.
// Automated Atticus engines use type=assembler and who=Device/{engine}.
* agent 1..* MS
* agent.who 1..1 MS
* agent.who only Reference(Practitioner or Patient or Device)
* agent.type MS
* agent.type from ProvenanceAgentTypeVS (extensible)
* agent.type ^short = "assembler for automated engines, author for source document authors"
* agent.onBehalfOf MS
* agent.onBehalfOf only Reference(Practitioner or Organization)

// Entity: source resource used as input (required for AI clipboard and definition-based import).
// For AI clipboard: entity.what references the DocumentReference; html-element-id extensions
// identify the specific labeled spans that were used for extraction.
* entity MS
* entity.role MS
* entity.what MS
* entity.what.reference MS
* entity.what.display MS
* entity.what.extension contains HtmlElementId named htmlElementId 0..* MS
* entity.what.extension[htmlElementId] ^short = "HTML element IDs from source document"
* entity.what.extension[htmlElementId] ^definition = "IDs of labeled HTML elements in the DocumentReference attachment that contain the text the AI used to derive the answer. Enables source-highlighting in the UI."


// -----------------------------------------------------------------------------
// Stub instances referenced by examples
// -----------------------------------------------------------------------------

Instance: qr-123
InstanceOf: QuestionnaireResponse
Usage: #example
Title: "Example QuestionnaireResponse"
Description: "Stub QuestionnaireResponse referenced by provenance examples"
* questionnaire = "http://fhir.tiro.health/Questionnaire/example"
* status = #completed
* authored = "2025-10-29T10:30:00Z"

Instance: pract-789
InstanceOf: Practitioner
Usage: #example
Title: "Example Practitioner"
Description: "Stub Practitioner referenced by provenance examples"
* name.text = "Dr. Example"

Instance: doc-001
InstanceOf: DocumentReference
Usage: #example
Title: "Example Clinical Document"
Description: "Stub DocumentReference representing a referral letter, referenced by the AI clipboard provenance example"
* status = #current
* description = "Referral letter from AZ Monica"
* content.attachment.contentType = #text/html
* content.attachment.title = "Referral letter from AZ Monica"


// -----------------------------------------------------------------------------
// Examples
// -----------------------------------------------------------------------------

Instance: prov-001
InstanceOf: FormProvenance
Usage: #example
Title: "User Input Provenance"
Description: "Provenance for a field manually entered by the treating clinician"
* target.reference = "QuestionnaireResponse/qr-123"
* target.extension[targetElement].valueUri = "item-456"
* recorded = "2025-10-29T10:30:00Z"
* activity.text = "Manually entered data by the user"
* activity.coding[tiroActivity].system = "http://fhir.tiro.health/CodeSystem/form-activity"
* activity.coding[tiroActivity].code = #user
* activity.coding[tiroActivity].display = "User input"
* activity.coding[isoLifecycle].system = "http://terminology.hl7.org/CodeSystem/iso-21089-lifecycle"
* activity.coding[isoLifecycle].code = #originate
* activity.coding[isoLifecycle].display = "Originate/Retain Record Lifecycle Event"
* agent.who.reference = "Practitioner/pract-789"


Instance: prov-002
InstanceOf: FormProvenance
Usage: #example
Title: "AI Clipboard Population Provenance"
Description: "Provenance for a field extracted by AI from a clinical document (contextual-populate). The entity carries the source DocumentReference and html-element-id extensions identifying the specific labeled spans used for extraction."
// ProvenanceWhy: structured AI reasoning (intended future location; backend currently uses activity.text)
* extension[why].valueMarkdown = """
The clinical note states: "CT thorax toont een massa van 4.2cm in de rechter bovenkwab met invasie van de thoraxwand."
This indicates a tumor >4cm with chest wall invasion, corresponding to cT3 per AJCC 8th edition staging criteria.
"""
* target.reference = "QuestionnaireResponse/qr-123"
* target.extension[targetElement].valueUri = "item-789"
* recorded = "2025-10-29T10:32:00Z"
// activity.text carries the AI reasoning in the current backend implementation
* activity.text = "CT toont massa van 4.2cm in rechter bovenkwab met thoraxwandinvasie → cT3 (AJCC 8th)"
* activity.coding[tiroActivity].system = "http://fhir.tiro.health/CodeSystem/form-activity"
* activity.coding[tiroActivity].code = #ai-clipboard
* activity.coding[tiroActivity].display = "AI Clipboard"
* activity.coding[isoLifecycle].system = "http://terminology.hl7.org/CodeSystem/iso-21089-lifecycle"
* activity.coding[isoLifecycle].code = #originate
* activity.coding[isoLifecycle].display = "Originate/Retain Record Lifecycle Event"
* agent.type.coding.system = "http://terminology.hl7.org/CodeSystem/provenance-participant-type"
* agent.type.coding.code = #assembler
* agent.type.coding.display = "Assembler"
* agent.who.reference = "Device/atticus-ai-population-engine"
* entity.role = #source
* entity.what.reference = "DocumentReference/doc-001"
* entity.what.display = "Referral letter from AZ Monica"
* entity.what.extension[htmlElementId][+].valueString = "label-001"
* entity.what.extension[htmlElementId][+].valueString = "label-002"


Instance: prov-003
InstanceOf: FormProvenance
Usage: #example
Title: "FHIRPath Calculation Provenance"
Description: "Provenance for a field computed by the FHIRPath engine from a calculatedExpression"
* target.reference = "QuestionnaireResponse/qr-123"
* target.extension[targetElement].valueUri = "item-999"
* recorded = "2025-10-29T10:33:00Z"
* activity.text = "A value computed from a FHIRPath calculatedExpression"
* activity.coding[tiroActivity].system = "http://fhir.tiro.health/CodeSystem/form-activity"
* activity.coding[tiroActivity].code = #calculation
* activity.coding[tiroActivity].display = "Calculation"
* activity.coding[isoLifecycle].system = "http://terminology.hl7.org/CodeSystem/iso-21089-lifecycle"
* activity.coding[isoLifecycle].code = #originate
* activity.coding[isoLifecycle].display = "Originate/Retain Record Lifecycle Event"
* agent.type.coding.system = "http://terminology.hl7.org/CodeSystem/provenance-participant-type"
* agent.type.coding.code = #assembler
* agent.type.coding.display = "Assembler"
* agent.who.reference = "Device/atticus-fhirpath-engine"


Instance: prov-004
InstanceOf: FormProvenance
Usage: #example
Title: "Definition-Based Import Provenance"
Description: "Provenance for a field populated by matching Questionnaire.item.definition to a FHIR Observation. The backend sends both #definition and #data-import as tiroActivity codings."
* target.reference = "QuestionnaireResponse/qr-123"
* target.extension[targetElement].valueUri = "item-444"
* recorded = "2025-10-29T10:34:00Z"
* activity.coding[tiroActivity][+].system = "http://fhir.tiro.health/CodeSystem/form-activity"
* activity.coding[tiroActivity][=].code = #definition
* activity.coding[tiroActivity][=].display = "Definition-based import"
* activity.coding[tiroActivity][+].system = "http://fhir.tiro.health/CodeSystem/form-activity"
* activity.coding[tiroActivity][=].code = #data-import
* activity.coding[tiroActivity][=].display = "Data Import"
* activity.coding[isoLifecycle].system = "http://terminology.hl7.org/CodeSystem/iso-21089-lifecycle"
* activity.coding[isoLifecycle].code = #originate
* activity.coding[isoLifecycle].display = "Originate/Retain Record Lifecycle Event"
* agent.type.coding.system = "http://terminology.hl7.org/CodeSystem/provenance-participant-type"
* agent.type.coding.code = #assembler
* agent.type.coding.display = "Assembler"
* agent.who.reference = "Device/atticus-population-engine"
* entity.role = #source
* entity.what.reference = "Observation/obs-789"
* entity.what.display = "Serum Creatinine Lab Result"


Instance: prov-005
InstanceOf: FormProvenance
Usage: #example
Title: "Preset Population Provenance"
Description: "Provenance for fields populated from a saved preset configuration. The backend sends both #preset and #static as tiroActivity codings."
* target.reference = "QuestionnaireResponse/qr-123"
* target.extension[targetElement].valueUri = "item-555"
* recorded = "2025-10-29T10:35:00Z"
* activity.coding[tiroActivity][+].system = "http://fhir.tiro.health/CodeSystem/form-activity"
* activity.coding[tiroActivity][=].code = #preset
* activity.coding[tiroActivity][=].display = "Preset"
* activity.coding[tiroActivity][+].system = "http://fhir.tiro.health/CodeSystem/form-activity"
* activity.coding[tiroActivity][=].code = #static
* activity.coding[tiroActivity][=].display = "Static value"
* activity.coding[isoLifecycle].system = "http://terminology.hl7.org/CodeSystem/iso-21089-lifecycle"
* activity.coding[isoLifecycle].code = #originate
* activity.coding[isoLifecycle].display = "Originate/Retain Record Lifecycle Event"
* agent.type.coding.system = "http://terminology.hl7.org/CodeSystem/provenance-participant-type"
* agent.type.coding.code = #assembler
* agent.type.coding.display = "Assembler"
* agent.who.reference = "Device/atticus-preset-engine"
* entity.role = #source
* entity.what.reference = "Basic/preset-mri-protocol"
* entity.what.display = "MRI Protocol Preset"

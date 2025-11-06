CodeSystem: FormActivity
Id: form-activity
Title: "Form Activity"
Description: "Activities that can be performed on form fields and which will be tracked through provenance"
* #user "User input" "Manually entered data by the user"
* #manual "Manual input" "Manually entered data by the user without additional system assistance"
* #static "Static value" "A preconfigured value that has been picked by a user. The values in the preset have been used to populate fields."
  * #preset "Preset" "Populated by preset"
  * #initial-value "Initial value" "Populated by an initial value"
* #calculation "Calculation" "A calculation has been performed to populate a field based on a predefined expression or formula."
  * #fhirpath "FHIRPath calculation" "A calculation has been performed using a FHIRPath expression."
* #ai "AI population" "An AI-algorithm has been generating values to populate form fields"
  * #speech-population "Speech-based population" "A speech to QuestionnaireResponse solution has generated the field values."
  * #ai-clipboard "AI Clipboard" "An AI-engine has processed clipboard content"
* #data-import "Data Import" "Import of values from other resources potentially coming from external servers."
* #submit "Submit" "Form has been submitted for review or final processing"
* #amend "Amend" "Form has been amended or updated after initial submission"


CodeSystem: AgentTypes
Id: agent-types
Title: "Agent Types"
Description: "Agent Types that process data to populate form fields."
* #fhirpath-engine "FHIRPath Engine" "FHIRPath expression engine"
* #population-engine "Population Engine" "Engine that populates forms from external data sources"
* #preset-engine "Preset Engine" "Engine that applies preset configurations"
* #x-fhir-query-resolver "X-FHIR Query Resolver" "Resolves x-fhir-query extensions"


ValueSet: FormActivityVS
Id: form-activity-vs
Title: "Form Activity ValueSet"
Description: "Activities that can be performed on form fields"
* include codes from system FormActivity


ValueSet: AgentTypesVS
Id: agent-types-vs
Title: "Agent Types ValueSet"
Description: "Types of automated agents that can populate form fields"
* include codes from system AgentTypes


Profile: FormProvenance
Parent: Provenance
Id: form-provenance
Title: "Form Provenance"
Description: "Profile for tracking the origin and method of data entry for form fields to support audit trails and transparency"
* ^purpose = "Track the origin and method of data entry for form fields to support audit trails and transparency"

// Target must reference QuestionnaireResponse and include targetElement
* target 1..* MS
* target only Reference(QuestionnaireResponse)
* target.extension contains http://hl7.org/fhir/StructureDefinition/targetElement named targetElement 1..1 MS
* target.extension[targetElement] ^short = "Specific item.linkId within the QuestionnaireResponse"
* target.extension[targetElement] ^definition = "Points to the specific item.linkId within the referenced QuestionnaireResponse that this provenance applies to"

// Activity must include Tiro activity code, optionally ISO lifecycle code
* activity 1..1 MS
* activity.coding 1..* MS
* activity.coding ^slicing.discriminator.type = #pattern
* activity.coding ^slicing.discriminator.path = "system"
* activity.coding ^slicing.rules = #open
* activity.coding ^slicing.description = "Slicing based on the code system"
* activity.coding contains
    tiroActivity 1..1 MS and
    isoLifecycle 0..1 MS
* activity.coding[tiroActivity].system = "http://fhir.tiro.health/CodeSystem/form-activity"
* activity.coding[tiroActivity] from FormActivityVS (required)
* activity.coding[tiroActivity] ^short = "Activity that was performed on the form field"
* activity.coding[tiroActivity] ^definition = "The specific Tiro-defined activity that was performed to populate or modify the form field"
* activity.coding[isoLifecycle].system = "http://terminology.hl7.org/CodeSystem/iso-21089-lifecycle"
* activity.coding[isoLifecycle] ^short = "ISO 21089 lifecycle event"
* activity.coding[isoLifecycle] ^definition = "Optional standard ISO 21089 lifecycle event corresponding to the activity"

// Recorded timestamp is required
* recorded 1..1 MS

// Agent constraints
* agent 1..* MS
* agent.who 1..1 MS
* agent.who only Reference(Practitioner or Patient or Device)
* agent.type MS
* agent.type from AgentTypesVS (extensible)
* agent.type ^short = "Type of agent (for automated systems)"
* agent.onBehalfOf MS
* agent.onBehalfOf only Reference(Practitioner or Organization)


// Example Instances

Instance: prov-001
InstanceOf: FormProvenance
Usage: #example
Title: "User Input Provenance Example"
Description: "Example of provenance tracking for manually entered user data"
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
Title: "AI Clipboard Population Provenance Example"
Description: "Example of provenance tracking for AI-powered clipboard processing"
* target.reference = "QuestionnaireResponse/qr-123"
* target.extension[targetElement].valueUri = "item-789"
* recorded = "2025-10-29T10:32:00Z"
* activity.text = "An AI-engine has processed clipboard content"
* activity.coding[tiroActivity].system = "http://fhir.tiro.health/CodeSystem/form-activity"
* activity.coding[tiroActivity].code = #ai-clipboard
* activity.coding[tiroActivity].display = "AI Clipboard"
* activity.coding[isoLifecycle].system = "http://terminology.hl7.org/CodeSystem/iso-21089-lifecycle"
* activity.coding[isoLifecycle].code = #originate
* activity.coding[isoLifecycle].display = "Originate/Retain Record Lifecycle Event"
* agent.who.display = "AI Engine"
* agent.onBehalfOf.reference = "Practitioner/pract-789"


Instance: prov-003
InstanceOf: FormProvenance
Usage: #example
Title: "FHIRPath Calculation Provenance Example"
Description: "Example of provenance tracking for automated FHIRPath calculations"
* target.reference = "QuestionnaireResponse/qr-123"
* target.extension[targetElement].valueUri = "item-999"
* recorded = "2025-10-29T10:33:00Z"
* activity.text = "A calculation has been performed using a FHIRPath expression"
* activity.coding[tiroActivity].system = "http://fhir.tiro.health/CodeSystem/form-activity"
* activity.coding[tiroActivity].code = #fhirpath
* activity.coding[tiroActivity].display = "FHIRPath calculation"
* activity.coding[isoLifecycle].system = "http://terminology.hl7.org/CodeSystem/iso-21089-lifecycle"
* activity.coding[isoLifecycle].code = #originate
* activity.coding[isoLifecycle].display = "Originate/Retain Record Lifecycle Event"
* agent.type.coding.system = "http://fhir.tiro.health/CodeSystem/agent-types"
* agent.type.coding.code = #fhirpath-engine
* agent.type.coding.display = "FHIRPath Engine"
* agent.who.display = "FHIRPath.js"
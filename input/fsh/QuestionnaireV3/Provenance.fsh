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
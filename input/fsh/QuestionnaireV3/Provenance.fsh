CodeSystem: FormActivity
Id: form-activity
Title: "Form Activity"
Description: "Activities that can be performed on form fields and which will be tracked through provenance"
* #user "User input" "Manually entered data by the user"
* #static "Static value" "A preconfigured value that has been picked by a user. The values in the preset have been used to populate fields."
  * #preset
  * #initial-value
* #calculation "Calculation" "A calculation has been performed to populate a field based on a predefined expression or formula."
  * #fhirpath "FHIRPath calculation" "A calculation has been performed using a FHIRPath expression."
* #ai "AI population" "An AI-algorithm has been generating values to populate form fields"
  * #speech-population "Speech-based population" "A speech to QuestionnaireResponse solution has generated the field values."
  * #ai-clipboard "AI Clipboard" "An AI-engine has processed clipboard content" 
* #data-import "Data Import" "Import of values from other resources potentially coming from external servers." 
Alias: $entryFormat = http://hl7.org/fhir/StructureDefinition/entryFormat
Alias: $minValue = http://hl7.org/fhir/StructureDefinition/minValue
Alias: $maxValue = http://hl7.org/fhir/StructureDefinition/maxValue
Alias: $maxDecimalPlaces = http://hl7.org/fhir/StructureDefinition/maxDecimalPlaces
Alias: $minLength = http://hl7.org/fhir/StructureDefinition/minLength
Alias: $regex = http://hl7.org/fhir/StructureDefinition/regex
Alias: $hidden = http://hl7.org/fhir/StructureDefinition/questionnaire-hidden
Alias: $maxOccurs = http://hl7.org/fhir/StructureDefinition/questionnaire-maxOccurs
Alias: $minOccurs = http://hl7.org/fhir/StructureDefinition/questionnaire-minOccurs
Alias: $optionExclusive = http://hl7.org/fhir/StructureDefinition/questionnaire-optionExclusive
Alias: $unit = http://hl7.org/fhir/StructureDefinition/questionnaire-unit
Alias: $itemWeight = http://hl7.org/fhir/StructureDefinition/itemWeight
Alias: $targetConstraint = http://hl7.org/fhir/StructureDefinition/questionnaire-targetConstraint
Alias: $renderingMarkdown = http://hl7.org/fhir/StructureDefinition/rendering-markdown
Alias: $preferredTerminologyServer = http://hl7.org/fhir/StructureDefinition/preferredTerminologyServer
Alias: $maxSize = http://hl7.org/fhir/StructureDefinition/maxSize
Alias: $mimeType = http://hl7.org/fhir/StructureDefinition/mimeType
Alias: $quantityPrecision = http://hl7.org/fhir/StructureDefinition/quantity-precision

// =============================================================================
// Validation, Constraint & Display Extensions
// =============================================================================
// The following standard FHIR and SDC extensions are supported by Tiro.health
// for questionnaire item validation, scoring, and display control.
//
// Input Validation:
//   - entryFormat: Placeholder/format hint displayed in input fields (e.g., "nnn-nnn-nnn")
//   - regex: Regular expression pattern the answer must match
//   - minValue / maxValue: Minimum and maximum numeric bounds
//   - maxDecimalPlaces: Maximum decimal precision allowed
//   - minLength / maxLength: String length constraints
//   - maxSize: Maximum file size in bytes (for attachment items)
//   - mimeType: Allowed MIME types (for attachment items)
//
// Occurrence Constraints:
//   - minOccurs / maxOccurs: Min/max instances for repeating items
//
// Answer Option Modifiers:
//   - optionExclusive: Marks an option as mutually exclusive (selecting it deselects others)
//   - optionRestriction: Conditionally restricts options based on FHIRPath expressions
//   - itemWeight: Numeric weight/score for an answer option (used in scoring questionnaires)
//
// Display Control:
//   - hidden: Hides an item from display (value still computed/populated)
//   - rendering-markdown: Indicates item text contains markdown for rich rendering
//   - preferredTerminologyServer: URI of preferred terminology server for ValueSet expansion
//   - quantity-precision: Display precision for quantity values
//
// Structural Constraints:
//   - targetConstraint: FHIRPath constraint enforced on instantiated resources
//     (e.g., "numerator <= denominator" across item answers)
// =============================================================================


// --- Extension: OptionRestriction (Tiro custom) ---

Extension: OptionRestriction
Id: questionnaire-optionRestriction
Title: "Option Restriction"
Description: "Conditionally restricts answer options based on FHIRPath expressions that evaluate other answers in the questionnaire. When the expression evaluates to true, the specified option is restricted (hidden or disabled)."
Context: Questionnaire.item
* extension contains
    option 1..* MS and
    expression 1..1 MS
* extension[option] ^short = "The answer option coding to restrict."
* extension[option].value[x] only Coding
* extension[expression] ^short = "FHIRPath expression that determines when this option is restricted."
* extension[expression].value[x] only Expression
* extension[expression].valueExpression.language = #text/fhirpath


// --- Example: Validated Measurement Input ---

Instance: ValidatedMeasurement
InstanceOf: TiroQuestionnaire
Usage: #example
Title: "Validated Measurement Input"
Description: "Example questionnaire demonstrating validation extensions: entryFormat, minValue, maxValue, maxDecimalPlaces, and regex."
* insert QuestionnaireV3
* url = "http://example.tiro.health/Questionnaire/validated-measurement"
* status = #draft
* name = "ValidatedMeasurement"
* title = "Validated Measurements"
* subjectType = #Patient

// Decimal with unit, min/max bounds, and decimal precision
* item[+]
  * linkId = "psa-value"
  * text = "PSA"
  * insert DecimalTextbox(#ng/mL)
  * extension[$entryFormat].valueString = "0.00"
  * extension[$minValue].valueDecimal = 0
  * extension[$maxValue].valueDecimal = 10000
  * extension[$maxDecimalPlaces].valueInteger = 2

// String with regex validation and entry format hint
* item[+]
  * linkId = "phone-number"
  * text = "Phone Number"
  * insert Textbox
  * extension[$entryFormat].valueString = "+32 xxx xx xx xx"
  * extension[$regex].valueString = "^\\+?[0-9\\s\\-]{6,20}$"
  * extension[$minLength].valueInteger = 6
  * maxLength = 20

// Hidden calculated item
* item[+]
  * linkId = "risk-category"
  * text = "Risk Category"
  * type = #string
  * readOnly = true
  * extension[$hidden].valueBoolean = true

Alias: $questionnaire-item-control = http://hl7.org/fhir/questionnaire-item-control
Alias: $library-type = http://terminology.hl7.org/CodeSystem/library-type
Alias: $itemControl = http://hl7.org/fhir/StructureDefinition/questionnaire-itemControl
Alias: $vsOrder = http://hl7.org/fhir/StructureDefinition/valueset-conceptOrder
Alias: $lookup = http://hl7.org/fhir/uv/sdc/StructureDefinition/sdc-questionnaire-lookupQuestionnaire
Alias: $optionsToggle = http://hl7.org/fhir/uv/sdc/StructureDefinition/sdc-questionnaire-answerOptionsToggleExpression
Alias: $variable = http://hl7.org/fhir/StructureDefinition/variable
Alias: $clinical-m-stage-lung-cancer-addendum = http://tiro.health/fhir/CodeSystem/clinical-m-stage-lung-cancer-addendum
Alias: $mime = http://terminology.hl7.org/CodeSystem/v3-mediatypes
Alias: $minValue = http://hl7.org/fhir/StructureDefinition/minValue
Alias: $maxValue = http://hl7.org/fhir/StructureDefinition/maxValue
Alias: $entryFormat = http://hl7.org/fhir/StructureDefinition/entryFormat
Alias: $calculated = http://hl7.org/fhir/uv/sdc/StructureDefinition/sdc-questionnaire-calculatedExpression
Alias: $regex = http://hl7.org/fhir/StructureDefinition/regex
Alias: $subQuestionnaire = http://hl7.org/fhir/uv/sdc/StructureDefinition/sdc-questionnaire-subQuestionnaire
Alias: $assemble-expectation = http://hl7.org/fhir/uv/sdc/StructureDefinition/sdc-questionnaire-assemble-expectation
Alias: $unit = http://hl7.org/fhir/StructureDefinition/questionnaire-unit

Profile: TiroQuestionnaire
Parent: Questionnaire
Id: tiro-questionnaire
Title: "Tiro Questionnaire"
Description: "Profile for a Tiro Questionnaire"
* extension contains
    RenderType named renderType 1..1 MS and
    Orientation named orientation 0..1

* item ^slicing.discriminator.type = #value
* item ^slicing.discriminator.path = "extension(http://hl7.org/fhir/StructureDefinition/questionnaire-itemControl)"
* item ^slicing.description = "Slice that splits the items between answer and subquestions"
* item ^slicing.ordered = true // Since order influences presentation for Questionnaires, this is important
* item ^slicing.rules = #openAtEnd
* item contains
    answer 0..1 MS
* item[answer]
  * type = #group
  * extension contains
    $itemControl named itemControl 1..1 MS
  * extension[itemControl].valueCodeableConcept.coding = $questionnaire-item-control#list "Answer Container"
    //* valueCodeableConcept
    //  * coding[+] = $questionnaire-item-control#list
    //  * coding[+] = TiroQuestionnaireItemControl#answer-container
    //  * text = "Answer Container"


Instance: TreeLayoutRenderer
InstanceOf: Library
Usage: #example
Title: "Tree Layout Renderer (Version 3)"
Description: "Render library to render a FHIR Questionnaire in a tree like question-answer layout"
* status = #active
* version = "3.0.0"
* type.text = "React/NPM package to render a FHIR Questionnaire"
* type.coding = $library-type#logic-library "Logic Library"
* name = "questionnaire-v3"
* title = "Questionnaire Version 3"
* purpose = "Render a FHIR Questionnaire in a tree like question-answer layout. This FHIR Library Resources is used to keep track of the version changes of the underlying React/NPM package."
* publisher = "Tiro Health"
* dataRequirement[+]
  * type = #Questionnaire
  * profile = Canonical(TiroQuestionnaire)

Instance: TableLayoutRenderer
InstanceOf: Library
Usage: #example
Title: "Table Layout Renderer"
Description: "Render library to render a FHIR Questionnaire in a table layout"
* status = #active
* version = "2.0.0"
* type.text = "React/NPM package to render a FHIR Questionnaire"
* type.coding = $library-type#logic-library "Logic Library"
* name = "table-v2"
* title = "Table Layout Renderer"
* purpose = "Render a FHIR Questionnaire in a table layout. This FHIR Library Resources is used to keep track of the version changes of the underlying React/NPM package."
* publisher = "Tiro Health"
* dataRequirement[+]
  * type = #Questionnaire
  * profile = Canonical(TiroQuestionnaire)

Extension: InputGroupSeparator
Id: input-group-separator
Title: "Input Group Separator"
Description: "A separator character for input groups."
Context: Questionnaire.item
* value[x] only string
* valueString 1..1 MS

RuleSet: LibraryItem
* date = 2024-06-20
* publisher = "Tiro.health"
* extension[$assemble-expectation]
  * valueCode = #assemble-child

Extension: RenderType
Id: render-type
Title: "Render Type"
Description: "Render Type extension for the FHIR Questionnaire resource which indicates the layout preference for the Questionnaire"
Context: Questionnaire
* value[x] only canonical

Extension: Regex
Id: regex
Title: "Regex"
Description: "Regular expression to validate the answer to a question"
Context: Questionnaire.item
* value[x] only string
* valueString 1..1 MS

Extension: AnswerComment
Id: answer-comment
Title: "Answer Comment"
Description: "Extension to add a comment to an answer in a QuestionnaireResponse"
Context: QuestionnaireResponse.item.answer
* value[x] only Annotation
* valueAnnotation 1..1 MS

CodeSystem: TemplateLanguages
Id: template-languages
Title: "Template Languages"
Description: "Available template languages to generate a narrative for a Questionnaire item"
* ^supplements = "http://hl7.org/fhir/CodeSystem/template-languages"
* ^content = #complete
* #text/x.tiro-health.liquid "Liquid" "Liquid template language with custom Tiro.health tags and filters."
* #text/x.tiro-health.jinja2 "Jinja2" "Jinja2 template language with custom Tiro.health tags and filters."

ValueSet: TemplateLanguages
Id: template-languages
Title: "Template Languages"
Description: "Available template languages to generate a narrative for a Questionnaire item"
* $mime#text/x.tiro-health.liquid "Liquid"
* $mime#text/x.tiro-health.jinja2 "Jinja2"

Extension: NarrativeTemplate
Id: narrative-template
Title: "Narrative Template"
Description: "Extension to add a template to generate a narrative for the QuestionnaireResponse"
Context: Questionnaire.item
* ^purpose = """
             Attach a narrative template to a Questionnaire to generate a narrative for the QuestionnaireResponse.
             """
* value[x] only Expression
* valueExpression.language from TemplateLanguages (required)

CodeSystem: QuestionnaireItemOrientation
Id: questionnaire-item-orientation
Title: "Questionnaire Item Orientation"
Description: "Orientation of the items in the Questionnaire"
* #horizontal "Horizontal"
* #vertical "Vertical"

ValueSet: QuestionnaireItemOrientation
Id: questionnaire-item-orientation
Title: "Questionnaire Item Orientation"
Description: "Orientation of the items in the Questionnaire"
* include codes from system QuestionnaireItemOrientation

Extension: Orientation
Id: orientation
Title: "Item Orientation"
Description: "Orientation of the items in the Questionnaire"
Context: Questionnaire, Questionnaire.item
* value[x] only code
* valueCode from QuestionnaireItemOrientation (required)

CodeSystem: TiroQuestionnaireItemControl
Id: tiro-questionnaire-item-control
Title: "Tiro Questionnaire Item Control"
Description: "Custom Questionnaire Item Control by Tiro Health"
* #question-group "Question Group" "Structure to group answers and subquestions in a hierarchical tree layout."
* #drop-down "Dropdown" "Dropdown to select a single answer from a list of options."
* #chips "Chips" "Chips to select one or more answers from a list of options."
* #text-box "Textbox" "Textbox to enter characters."
* #text-area "Text Area" "Text area to enter multiple lines of text."
* #date-field "Date Field" "Date field to enter a date."
* #calculator "Calculator" "Calculator to calculate a value based on a formula."

Extension: EnableSuggestions
Id: enable-suggestions
Title: "Enable Suggestions"
Description: "Enable suggestions for inline mentions in text fields"
Context: Questionnaire.item
* value[x] only boolean
* valueBoolean 1..1 MS

RuleSet: AnswerContainer
* type = #group
* extension[+]
  * url = "http://hl7.org/fhir/StructureDefinition/questionnaire-itemControl"
  * valueCodeableConcept.text = "Answer Container"
  * valueCodeableConcept.coding[0] = $questionnaire-item-control#list
  * valueCodeableConcept.coding[1] = TiroQuestionnaireItemControl#answer-container

RuleSet: AnswerRow
* type = #group
* extension[+]
  * url = "http://hl7.org/fhir/StructureDefinition/questionnaire-itemControl"
  * valueCodeableConcept.text = "Answer Row"
  * valueCodeableConcept.coding[0] = $questionnaire-item-control#list
  * valueCodeableConcept.coding[1] = TiroQuestionnaireItemControl#answer-row

RuleSet: QuestionGroup
* type = #group
* extension[+]
  * url = "http://hl7.org/fhir/StructureDefinition/questionnaire-itemControl"
  * valueCodeableConcept.text = "Question Container"
  * valueCodeableConcept.coding[0] = $questionnaire-item-control#list
  * valueCodeableConcept.coding[1] = TiroQuestionnaireItemControl#question-group

RuleSet: CodingDropdown
* type = #coding
* extension[+]
  * url = "http://hl7.org/fhir/StructureDefinition/questionnaire-itemControl"
  * valueCodeableConcept.text = "Coding Dropdown"
  * valueCodeableConcept.coding[0] = $questionnaire-item-control#drop-down
  * valueCodeableConcept.coding[0] = TiroQuestionnaireItemControl#drop-down

RuleSet: CodingChips
* type = #coding
* extension[+]
  * url = "http://hl7.org/fhir/StructureDefinition/questionnaire-itemControl"
  * valueCodeableConcept.text = "Coding Chips"
  * valueCodeableConcept.coding[0] = $questionnaire-item-control#check-box
  * valueCodeableConcept.coding[1] = TiroQuestionnaireItemControl#chips

RuleSet: SupportLink(url)
* extension[+]
  * url = "http://hl7.org/fhir/StructureDefinition/questionnaire-supportLink"
  * valueUri = "{url}"

RuleSet: DecimalTextbox(unit)
* type = #decimal
* extension[+]
  * url = "http://hl7.org/fhir/StructureDefinition/questionnaire-itemControl"
  * valueCodeableConcept.text = "Decimal Textbox"
  * valueCodeableConcept.coding[0] = $questionnaire-item-control#text-box
  * valueCodeableConcept.coding[1] = TiroQuestionnaireItemControl#text-box
* extension[+]
  * url = "http://hl7.org/fhir/StructureDefinition/questionnaire-unit"
  * valueCoding = $UCUM{unit}

RuleSet: Textbox
* type = #string
* extension[+]
  * url = "http://hl7.org/fhir/StructureDefinition/questionnaire-itemControl"
  * valueCodeableConcept.text = "Textbox"
  * valueCodeableConcept.coding[0] = $questionnaire-item-control#text-box
  * valueCodeableConcept.coding[1] = TiroQuestionnaireItemControl#text-box

RuleSet: DateField
* type = #date
* extension[+]
  * url = "http://hl7.org/fhir/StructureDefinition/questionnaire-itemControl"
  * valueCodeableConcept.text = "Textbox"
  * valueCodeableConcept.coding[0] = $questionnaire-item-control#text-box
  * valueCodeableConcept.coding[1] = TiroQuestionnaireItemControl#date-field

RuleSet: Calculator
* type = #reference
* extension[+]
  * url = "http://hl7.org/fhir/StructureDefinition/questionnaire-itemControl"
  * valueCodeableConcept.text = "Calculator"
  * valueCodeableConcept.coding[0] = $questionnaire-item-control#lookup
  * valueCodeableConcept.coding[1] = TiroQuestionnaireItemControl#calculator

RuleSet: TextArea
* type = #text
* extension[+]
  * url = "http://hl7.org/fhir/StructureDefinition/questionnaire-itemControl"
  * valueCodeableConcept.text = "Text Area"
  * valueCodeableConcept.coding[0] = $questionnaire-item-control#text-area
  * valueCodeableConcept.coding[1] = TiroQuestionnaireItemControl#text-area

RuleSet: QuestionnaireV3
* extension[RenderType].valueCanonical = Canonical(TreeLayoutRenderer)

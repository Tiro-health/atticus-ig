Profile: TemplateBlock
Parent: Questionnaire
Id: TemplateBlock
Title: "TemplateBlock"
Description: "A template block is a section of a template that defines a block of content that can be included in a document."
* url 1..1 MS
* status 1..1 MS
* subjectType = #Patient

Profile: Table
Parent: TemplateBlock
Id: Table
Title: "Table"
Description: "A table is a template block that contains a repeating set of rows with a uniform set of columns."
* url 1..1 MS
* status 1..1 MS
* subjectType = #Patient
* item 1..1 MS
* item ^short = "Record of a table."
* item ^definition = "The group of items that make up a record in the table."
  * linkId = #record
  * type 1..1 MS
  * type = #group (exactly)
  * repeats 1..1 MS
  * repeats = true
  * item 1..* MS
  * item ^short = "A column in the table."
  * item ^definition = "A column in the table."
    * repeats = false

ValueSet: QuestionTreeAnswerItemCode
Id: question-tree-answer-item-code
Title: "Question Tree Answer Item Code"
Description: "The type of an answer in a question tree."
* include codes from system http://hl7.org/fhir/ValueSet/questionnaire-item-type
* exclude http://hl7.org/fhir/item-type#code

Profile: QuestionTree
Parent: TemplateBlock
Id: QuestionTree
Title: "QuestionTree"
Description: "A question tree is a template block that contains a tree of questions. Each question may have one or more answers and may have one or more child questions."
* url 1..1 MS
* status 1..1 MS
* subjectType = #Patient
* item 0..* MS 
* item.type = #group
* item ^short = "A question in the tree."
* item ^definition = "A question in the tree."
* item
  * item ^slicing.discriminator.type = #value
  * item ^slicing.discriminator.path = "type"
  * item ^slicing.rules = #closed
  * item ^slicing.ordered = true
  * item ^slicing.description = "Items contain answers first and then child questions."
  * item contains
    answer 0..* and
    childQuestion 0..*
  * item[answer].type = #choice
  * item[answer].repeats = false
  * item[childQuestion].type = #group


Instance: TableExample
InstanceOf: Table
Usage: #example
Title: "Example Table"
Description: "An example table."
* url = "http://example.com/table"
* status = #draft
* item[+]
  * item[+].type = #date
  * item[=].linkId = "Datum"
  * item[+].type = #string
  * item[=].linkId = "Omschrijving"


//Resource: TiroHealthTemplateBlock
//Parent: DomainResource
//Id: TiroHealthTemplateBlock
//Title: "Template Block"
//Description: "A template block is a section of a template that defines a block of content that can be included in a document. The block may contain text, data fields, a questionnaire, or combinations of these."
//* url 0..1 uri "The canonical URL for this template block"
//* status 1..1 code "The status of this template block"
//* status from PublicationStatus (required)
//* title 0..1 string "The human-friendly name of this template block"
//* documentType 0..1 CodeableConcept "The type of document that this template block is intended for"
//* focus 0..1 CodeableConcept "The focus of this template block"
//* content 0..1 base64Binary "The content of this template block"


//Mapping: TemplateBlock
//Source: TiroHealthTemplateBlock
//Target: "TemplateBlock"
//Id: TemplateBlock
//Title: "TemplateBlock"
//Description: "A mapping between the TiroHealthTemplateBlock and the TemplateBlock profile."
//* url -> "url"

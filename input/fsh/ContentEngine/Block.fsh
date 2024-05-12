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
* item.linkId = #record
* item.type 1..1 MS
* item.type = #group (exactly)
* item.repeats 1..1 MS
* item.repeats = true
* item.item 1..* MS
* item.item ^short = "A column in the table."
* item.item ^definition = "A column in the table."
* item.item.repeats = false

Profile: QuestionTree
Parent: TemplateBlock
Id: QuestionTree
Title: "QuestionTree"
Description: "A question tree is a template block that contains a tree of questions. Each question may have one or more answers and may have one or more child questions."
* url 1..1 MS
* status 1..1 MS
* subjectType = #Patient
* item 1..1 MS 
* item ^short = "A question in the tree."
* item ^definition = "A question in the tree."

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

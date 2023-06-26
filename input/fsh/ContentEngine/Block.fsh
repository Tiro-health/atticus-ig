Profile: TemplateBlock
Parent: Questionnaire 
Id: TemplateBlock
Title: "TemplateBlock"
Description: "A template block is a section of a template that defines a block of content that can be included in a document."
* url 1..1 MS
* status 1..1 MS
* subjectType = #Patient

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

Extension: QuestionnaireAnswerOptionSVGElementBinding
Id: questionnaire-answerOption-svgElementBinding
Title: "Questionnaire answerOption SVG Element"
Description: "Reference to an element defined inside the SVG document referenced by the itemMedia extension."
Context: Questionnaire.item.answerOption
* value[x] only uri
* valueUri 1..1 MS 
* valueUri ^comment = "The URI should be a fragment identifier that points to an element inside the SVG document, e.g. '#icon1'."
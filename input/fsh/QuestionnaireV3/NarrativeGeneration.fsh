
Extension: NarrativeGeneration
Id: narrative-generation
Title: "Narrative Generation"
Description: "This extension is used to define the narrative generation based on the QuestionnaireResponse."
Context: Questionnaire, Questionnaire.item
* extension contains
    default 1..1 MS and
    empty 0..1 MS and
    answerOption 1..* and
    aggregator 0..1
* extension[default] ^short = "Default text generation for the answer."
* extension[default].value[x] only Expression
* extension[empty] ^short = "Text generation if no answer is given."
* extension[empty].value[x] only Expression
* extension[answerOption] ^short = "Text generation for specific answer options."
* extension[answerOption]
  * extension contains
      template 1..1 and
      answer 1..1
  * extension[template] ^short = "Template for the answer option"
  * extension[template].value[x] only Expression
  * extension[answer] ^short = "Answer option"
* extension[aggregator] ^short = "Aggregator for multiple answers. Only used if `repeats` is set to `true`."
* extension[aggregator].value[x] only string

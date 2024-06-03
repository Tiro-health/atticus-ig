CodeSystem: ExampleCode
Id: example-code
Title: "Example Code"
Description: "Example code for use in examples."
* #code1 "Example Code 1"
* #code2 "Example Code 2"
* #code3 "Example Code 3" 

Instance: MultipleChoiceExample
InstanceOf: Questionnaire
Usage: #example
Title: "Multiple Choice Example"
Description: "Questionnaire demonstrating the use of multiple choice questions defined as seperate items."
* status = #active
* item[0]
  * linkId = "question"
  * type = #group
  * text = "Question"
  * item[+]
    * linkId = "question/button-1"
    * type = #group 
    * item[+]
      * linkId = "question/button-1/answer"
      * type = #coding
      * text = "Button 1"
      * code = ExampleCode#code1
    * item[+]
      * linkId = "question/button-1/comments"
      * type = #string
  * item[+]
    * linkId = "question/button-2"
    * type = #group
    * item[+]
      * linkId = "question/button-2/answer"
      * type = #coding
      * text = "Button 2"
      * code = ExampleCode#code2
    * item[+]
      * linkId = "question/button-2/comments"
      * type = #string
  * item[+]
    * linkId = "question/button-3"
    * type = #group
    * item[+]
      * linkId = "question/button-3/answer"
      * type = #coding
      * text = "Button 3"
      * code = ExampleCode#code3
    * item[+]
      * linkId = "question/button-3/comments"
      * type = #string

Instance: MultipleChoiceResponseExample
InstanceOf: QuestionnaireResponse
Usage: #example
Title: "Multiple Choice Response Example"
Description: "Questionnaire response demonstrating the use of multiple choice questions defined as seperate items."
* contained[0] = MultipleChoiceExample
* questionnaire = Canonical(MultipleChoiceExample)
* status = #completed
* item[+]
  * linkId = "question"
  * text = "Question"
  * item[+]
    * linkId = "question/button-1"
    * item[+]
      * linkId = "question/button-1/answer"
      * text = "Button 1"
      * answer
        * valueCoding = ExampleCode#code1
    * item[+]
      * linkId = "question/button-1/comments"
      * answer
        * valueString = "Button 1 comments"
  * item[+]
    * linkId = "question/button-3"
    * item[+]
      * linkId = "question/button-3/answer"
      * text = "Button 3"
      * answer
        * valueCoding = ExampleCode#code3 


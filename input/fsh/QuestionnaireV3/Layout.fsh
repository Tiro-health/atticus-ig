Instance: NestedAnswerHorizontal
InstanceOf: Questionnaire
Usage: #example
Title: "Nested Answer Horizontal"
Description: "This is an example of a nested answer horizontal question."
* status = #active 
* item[+]
  * linkId = "1"
  * text = "Do you have any children?"
  * type = #boolean
  * item[+]
    * linkId = "1.1"
    * text = "Number of children"
    * type = #integer
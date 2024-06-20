Instance: NestedRadio1
InstanceOf: Questionnaire
Usage: #example
Title: "Nested Radio 1"
Description: "This is an example of a nested radio question."
* status = #active
* item
  * linkId = "1"
  * text = "Additional procedures performed:" 
  * type = #code
  * answerOption[+].valueCoding = $SCT#39270003 "adhesiolyse"
  * answerOption[+].valueCoding = $SCT#58347006 "lyphadenectomy"
  * answerOption[+].valueCoding = $SCT#177860007 "repair of inguinal hernia"
  * answerOption[+].valueCoding = $SCT#44946007 "repair of femoral hernia"
  * item[+]
    * linkId = "1.1"
    * type = #code
    * enableWhen[+]
      * question = "1"
      * operator = #=
      * answerCoding = $SCT#177860007
    * answerOption[+].valueCoding = $SCT#7771000 "left"
    * answerOption[+].valueCoding = $SCT#24028007 "right"
    * answerOption[+].valueCoding = $SCT#51440002 "bilateral"
  * item[+]
    * linkId = "1.2"
    * type = #code
    * enableWhen[+]
      * question = "1"
      * operator = #=
      * answerCoding = $SCT#44946007
    * answerOption[+].valueCoding = $SCT#428649003 "primary"
    * answerOption[+].valueCoding = $SCT#1173011006 "mesh"

Instance: NestedRadio2
InstanceOf: Questionnaire
Usage: #example
Title: "Nested Radio 2"
Description: "This is an example of a nested radio question."
* status = #active
* item[+]
  * linkId = "1"
  * text = "Additional procedures performed:" 
  * type = #group
  * item[+]
    * linkId = "1.1"
    * code = $SCT#39270003 "adhesiolyse"
    * type = #boolean
  * item[+]
    * linkId = "1.2"
    * code = $SCT#58347006 "lyphadenectomy"
    * type = #boolean
  * item[+]
    * linkId = "1.3"
    * code = $SCT#177860007 "repair of inguinal hernia"
    * type = #boolean
    * item[+]
      * linkId = "1.3.1"
      * type = #code
      * answerOption[+].valueCoding = $SCT#7771000 "left"
      * answerOption[+].valueCoding = $SCT#24028007 "right"
      * answerOption[+].valueCoding = $SCT#51440002 "bilateral"
  * item[+]
    * linkId = "1.4"
    * code = $SCT#44946007 "repair of femoral hernia"
    * type = #boolean
    * item[+]
      * linkId = "1.4.1"
      * type = #code
      * answerOption[+].valueCoding = $SCT#428649003 "primary"
      * answerOption[+].valueCoding = $SCT#1173011006 "mesh"
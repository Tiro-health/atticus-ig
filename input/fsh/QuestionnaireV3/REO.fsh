Alias: $questionnaire-item-control = http://hl7.org/fhir/questionnaire-item-control
Alias: $library-type = http://terminology.hl7.org/CodeSystem/library-type

Instance: QuestionnaireRenderer
InstanceOf: Library 
Usage: #example
Title: "Questionnaire Renderer Version 3"
Description: "Render library to render a FHIR Questionnaire in a tree like question-answer layout"
* status = #active
* url = "http://tiro.health/render-type/questionnaire|v3.0.0"
* version = "3.0.0"
* type.text = "React/NPM package to render a FHIR Questionnaire"
* type.coding = $library-type#logic-library "Logic Library"
* name = "questionnaire-v3"
* title = "Questionnaire Version 3"
* purpose = "Render a FHIR Questionnaire in a tree like question-answer layout. This FHIR Library Resources is used to keep track of the version changes of the underlying React/NPM package."
* publisher = "Tiro Health"

Extension: RenderType
Id: render-type
Title: "Render Type"
Description: "Render Type extension for the FHIR Questionnaire resource which indicates the layout preference for the Questionnaire"
Context: Questionnaire
* value[x] only canonical

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
Id: Orientation
Title: "Item Orientation"
Description: "Orientation of the items in the Questionnaire"
Context: Questionnaire, Questionnaire.item
* value[x] only code
* valueCode from QuestionnaireItemOrientation (required)

CodeSystem: TiroHealthQuestionnaireItemControl
Id: tiro-health-questionnaire-item-control
Title: "Tiro Health Questionnaire Item Control"
Description: "Custom Questionnaire Item Control by Tiro Health"
* #answer-container "Answer Container" "Container for answers (rows) part of a question."
* #answer-row "Answer Row" "Row of answers part of a question."
* #question-container "Question Container" "Structure to group answers and subquestions in a hierarchical tree layout."
* #comments "Comments" "Text field to add comments to a question. This component is visually more subtle than a full text field."
* #drop-down "Dropdown" "Dropdown to select a single answer from a list of options."
* #chips "Chips" "Chips to select one or more answers from a list of options."

RuleSet: AnswerContainer
* type = #group
* extension[+]
  * url = "http://hl7.org/fhir/StructureDefinition/questionnaire-itemControl"
  * valueCodeableConcept.text = "Answer Container" 
  * valueCodeableConcept.coding[0] = $questionnaire-item-control#list
  * valueCodeableConcept.coding[1] = TiroHealthQuestionnaireItemControl#answer-container

RuleSet: AnswerRow
* type = #group
* extension[+]
  * url = "http://hl7.org/fhir/StructureDefinition/questionnaire-itemControl"
  * valueCodeableConcept.text = "Answer Row" 
  * valueCodeableConcept.coding[0] = $questionnaire-item-control#list
  * valueCodeableConcept.coding[1] = TiroHealthQuestionnaireItemControl#answer-row

RuleSet: QuestionContainer
* type = #group
* extension[+]
  * url = "http://hl7.org/fhir/StructureDefinition/questionnaire-itemControl"
  * valueCodeableConcept.text = "Question Container" 
  * valueCodeableConcept.coding[0] = $questionnaire-item-control#list
  * valueCodeableConcept.coding[1] = TiroHealthQuestionnaireItemControl#question-container

RuleSet: Comments
* type = #text
* extension[+]
  * url = "http://hl7.org/fhir/StructureDefinition/questionnaire-itemControl"
  * valueCodeableConcept.text = "Comments" 
  * valueCodeableConcept.coding[0] = $questionnaire-item-control#text
  * valueCodeableConcept.coding[1] = TiroHealthQuestionnaireItemControl#comments

RuleSet: CodingDropdown
* type = #coding
* extension[+]
  * url = "http://hl7.org/fhir/StructureDefinition/questionnaire-itemControl"
  * valueCodeableConcept.text = "Coding Dropdown" 
  * valueCodeableConcept.coding[0] = $questionnaire-item-control#drop-down
  * valueCodeableConcept.coding[0] = TiroHealthQuestionnaireItemControl#drop-down

RuleSet: CodingChips
* type = #coding
* extension[+]
  * url = "http://hl7.org/fhir/StructureDefinition/questionnaire-itemControl"
  * valueCodeableConcept.text = "Coding Chips" 
  * valueCodeableConcept.coding[0] = $questionnaire-item-control#check-box
  * valueCodeableConcept.coding[1] = TiroHealthQuestionnaireItemControl#chips 

/**
 * REO Multidisciplinary Discussion Template 
 */

CodeSystem: UZLeuvenREOAddendum 
Id: uz-leuven-reo-addendum 
Title: "Addition codes to be used with the REO Multidisciplinary Discussion at UZ Leuven"
Description: "Extra codes for the REO Multidisciplinary Discussion at UZ Leuven"
* ^content = #complete
* #nsclc-nos "NSCLC NOS" "Non-Small Cell Lung Cancer, not otherwise specified"
* #carcinoid-nos "Carcinoïd NOS" "Carcinoid, not otherwise specified"
* #carcinoma-mixed "Mixed Carcinoma" "Mixed Carcinoma"
* #extra-thoracic-lymph-nodes "Extrathoracic lymph nodes" "Extrathoracic lymph nodes"

ValueSet: LungCancerDiagnosis
Id: lung-cancer-diagnosis
Title: "Lung Cancer Diagnosis"
Description: "Diagnosis of Lung Cancer"
* ^language = #nl-BE
* $SCT#255725002 "NSCLC - adenocarcinoom"
* $SCT#723301009 "NSCLC - spinocellulair carcinoom"
* UZLeuvenREOAddendum#nsclc-nos "NSCLC NOS"
* $SCT#1260072008 "NSCLC - sarcomatoïd carcinoom"
* $SCT#254632001 "Kleincellig longcarcinoom (SCLC)"
* $SCT#189607006 "Carcinoïd - Typisch"
* $SCT#128658008 "Carcinoïd - Atypisch"
* UZLeuvenREOAddendum#carcinoid-nos "Carcinoïd NOS"
* $SCT#65278006 "Mesothelioom - Epithelioïd"
* $SCT#399477001 "Mesothelioom - Sarcomatoïd"
* UZLeuvenREOAddendum#carcinoma-mixed "Mixed Carcinoma"
* $SCT#128628002 "Large cell neuroendocrine carcinoma (LCNEC)"
* $SCT#707596000 "Carcinosarcoma"
* $SCT#11671000 "Adenoïd cystisch carcinoma" 
* $SCT#373068000 "Onbekend"
* $SCT#74964007 "Andere" // this should be covered by the `Questionnaire.item.answerConstraint` field

ValueSet: LungCancerLocationOfMetastasis
Id: lung-cancer-location-of-metastasis
Title: "Lung Cancer Location Of Metastasis"
Description: "Location of metastasis for Lung Cancer"
* $SCT#94222008 "bot"
* $SCT#94225005 "hersenen"
* $SCT#94493005 "pleura"
* $SCT#94161006 "bijnier"
* $SCT#94381002 "lever"
* $SCT#94391008 "long"
* UZLeuvenREOAddendum#extra-thoracic-lymph-nodes "extrathoracale lymfeklieren" 

Instance: REOPreviousProblem
InstanceOf: Questionnaire
Usage: #example
Title: "REO Previous Problem"
Description: "Previous problems overview for REO Multidisplincary Discussion"
* status = #active
* version = "5.0.1"
* language = #nl-BE
* extension[RenderType].valueCanonical = Canonical(QuestionnaireRenderer) 
* extension[Orientation].valueCode = #vertical
* item[0]
  * linkId = "presentatie"
  * text = "# Presentatie" // some syntax to automatically generate a ordinal prefix
  * type = #group
  * repeats = true
  * code = $SCT#255259006 "First presentation" // probably not the right code
  * item[+] // DATE OF DIAGNOSIS
    * insert QuestionContainer
    * linkId = "presentatie/incidentie-datum"
    * text = "IncidentieDatum"
    * code =  $SCT#432213005 "Date of diagnosis"
    * item[0]
      * insert AnswerContainer
      * linkId = "presentatie/incidentie-datum/answer"
      * item[0]
        * insert AnswerRow
        * linkId = "presentatie/incidentie-datum/answer/row-0"
        * item[0]
          * linkId = "presentatie/incidentie-datum/answer/row-0/date"
          * type = #date
          * required = true
          * code =  $SCT#432213005 "Date of diagnosis" // maybe overkill??
        * item[1]
          * insert Comments
          * linkId = "presentatie/incidentie-datum/answer/row-0/comments"

  * item[+] // DIAGNOSIS
    * insert QuestionContainer
    * linkId = "presentatie/diagnose"
    * text = "Diagnose"
    * code =  $SCT#439401001 "Diagnosis"
    * item[0]
      * insert AnswerContainer
      * linkId = "presentatie/diagnose/answer"
      * item[0]
        * insert AnswerRow
        * linkId = "presentatie/diagnose/answer/row-0"
        * item[0]
          * insert CodingDropdown
          * linkId = "presentatie/diagnose/answer/row-0/diagnose"
          * type = #coding
          * code =  $SCT#432213005 "Diagnosis"
          * answerValueSet = Canonical(LungCancerDiagnosis)
          * answerConstraint = #optionsOrString
        * item[1]
          * insert Comments
          * linkId = "presentatie/diagnose/answer/row-0/comments"
      // SPECIFY OTHER??
    * item[+] // SUBQUESTIONS
      * insert QuestionContainer
      * linkId = "presentatie/diagnose/primaire-tumorlokalisatie"
      * text = "Primaire tumorlokalisatie"
      * code =  $SCT#399687005 "Primary tumor site"
      // Not relevant if the diagnosis is mesothelioma
      * enableWhen[+]
        * question = "presentatie/diagnose/answer/row-0/diagnose"
        * operator = #!=
        * answerCoding = $SCT#399477001 "Mesothelioom - Sarcomatoïd"
      * enableWhen[+]
        * question = "presentatie/diagnose/answer/row-0/diagnose"
        * operator = #!=
        * answerCoding = $SCT#65278006 "Mesothelioom - Epithelioïd"
      * enableWhen[+]
        * question = "presentatie/diagnose/answer/row-0/diagnose"
        * operator = #exists
        * answerBoolean = true
      * enableBehavior = #all
      * disabledDisplay = #hidden
      * item[0]
        * insert AnswerContainer
        * linkId = "presentatie/diagnose/primaire-tumorlokalisatie/answer"
        * item[+]
          * insert AnswerRow
          * linkId = "presentatie/diagnose/primaire-tumorlokalisatie/answer/row-0"
          * item[0]
            * linkId = "presentatie/diagnose/primaire-tumorlokalisatie/answer/row-0/lokalisatie-links"
            * type = #coding
            * answerOption[+].valueCoding = $SCT#82414001 "linker long"
            * answerOption[+].valueCoding = $SCT#82407001 "linker onderkwab"
            * answerOption[+].valueCoding = $SCT#82408000 "linker bovenkwab"
          * item[1]
            * insert Comments
            * linkId = "presentatie/diagnose/primaire-tumorlokalisatie/answer/row-0/comments"
        * item[+]
          * insert AnswerRow
          * linkId = "presentatie/diagnose/primaire-tumorlokalisatie/answer/row-1"
          * item[0]
            * linkId = "presentatie/diagnose/primaire-tumorlokalisatie/answer/row-1/lokalisatie-rechts"
            * type = #coding
            * answerOption[+].valueCoding = $SCT#64353002 "rechter onderkwab"
            * answerOption[+].valueCoding = $SCT#113250009 "rechter middenkwab"
            * answerOption[+].valueCoding = $SCT#11339004 "rechter bovenkwab"
          * item[1]
            * insert Comments
            * linkId = "presentatie/diagnose/primaire-tumorlokalisatie/answer/row-1/comments"
        * item[+]
          * insert AnswerRow
          * linkId = "presentatie/diagnose/primaire-tumorlokalisatie/answer/row-2"
          * item[0]
            * linkId = "presentatie/diagnose/primaire-tumorlokalisatie/answer/row-2/lokalisatie-hoofdbronchus"
            * type = #coding
            * answerOption[+].valueCoding = $SCT#75245000 "hoofdbronchus Li"
            * answerOption[+].valueCoding = $SCT#70074004 "hoofdbronchus Re"
            * answerOption[+].valueCoding = $SCT#44567001 "trachea"
          * item[1]
            * insert Comments
            * linkId = "presentatie/diagnose/primaire-tumorlokalisatie/answer/row-2/comments"
    * item[+] // SUBQUESTIONS
      * insert QuestionContainer
      * linkId = "presentatie/diagnose/primaire-tumorlokalisatie-mesothelioom"
      * text = "Primaire tumorlokalisatie"
      * code = $SCT#399687005 "Primary tumor site" 
      * enableWhen[+]
        * question = "presentatie/diagnose/answer/row-0/diagnose"
        * operator = #=
        * answerCoding = $SCT#399477001 "Mesothelioom - Sarcomatoïd"
      * enableWhen[+]
        * question = "presentatie/diagnose/answer/row-0/diagnose"
        * operator = #=
        * answerCoding = $SCT#65278006 "Mesothelioom - Epithelioïd"
      * enableBehavior = #any
      * disabledDisplay = #hidden
      * item[0]
        * insert AnswerContainer
        * linkId = "presentatie/diagnose/primaire-tumorlokalisatie-mesothelioom/answer"
        * item[+]
          * insert AnswerRow
          * linkId = "presentatie/diagnose/primaire-tumorlokalisatie-mesothelioom/answer/row-0"
          * item[0]
            * insert CodingChips
            * linkId = "presentatie/diagnose/primaire-tumorlokalisatie-mesothelioom/answer/row-0/lokalisatie-mesothelioom"
            * type = #coding
            * answerOption[+].valueCoding = $SCT#40768004 "links"
            * answerOption[+].valueCoding = $SCT#51872008 "rechts"
          * item[1]
            * insert Comments
            * linkId = "presentatie/diagnose/primaire-tumorlokalisatie-mesothelioom/answer/row-0/comments"
    * item[+]
      * insert QuestionContainer
      * linkId = "presentatie/diagnose/tnm-classificatie"
      * text = "TNM classification" 
      * code = $SCT#399566009 "TNM category"
      * enableWhen[+]
        * question = "presentatie/diagnose/answer/row-0/diagnose"
        * operator = #!=
        * answerCoding = $SCT#399477001 "Mesothelioom - Sarcomatoïd"
      * enableWhen[+]
        * question = "presentatie/diagnose/answer/row-0/diagnose"
        * operator = #!=
        * answerCoding = $SCT#65278006 "Mesothelioom - Epithelioïd"
      * enableWhen[+]
        * question = "presentatie/diagnose/answer/row-0/diagnose"
        * operator = #exists
        * answerBoolean = true
      * enableBehavior = #all
      * item[+]
        * insert AnswerContainer
        * linkId = "presentatie/diagnose/tnm-classificatie/answer"
        * item[+]
          * linkId = "presentatie/diagnose/tnm-classificatie/answer/row-0"
          * insert AnswerRow
          * item[+]
            * insert CodingDropdown
            * linkId = "presentatie/diagnose/tnm-classificatie/answer/row-0/t-stage"
            * code = $SCT#399504009 "cT category"
            * text = "cT-stage"
            * answerValueSet = "http://tiro.health/fhir/ValueSet/clinical-t-stage-lung-cancer"
          * item[+]
            * insert CodingDropdown
            * linkId = "presentatie/diagnose/tnm-classificatie/answer/row-0/n-stage"
            * code = $SCT#277206009 "cN category"
            * text = "cN-stage"
            * answerValueSet = "http://tiro.health/fhir/ValueSet/clinical-n-stage-lung-cancer"
          * item[+]
            * insert CodingDropdown
            * linkId = "presentatie/diagnose/tnm-classificatie/answer/row-0/m-stage"
            * code = $SCT#399387003 "cM category"
            * text = "cM-stage"
            * answerValueSet = "http://tiro.health/fhir/ValueSet/clinical-m-stage-lung-cancer" 
          * item[+]
            * insert Comments
            * linkId = "presentatie/diagnose/tnm-classificatie/answer/row-0/comments"
        * item[+]
          * insert QuestionContainer
          * linkId = "presentatie/diagnose/tnm-classificatie/locatie-metastase"
          * text = "Locatie van metastase"
          * code = $SCT#385421009 "Site of distant metastasis"
          * repeats = true
          * enableWhen[+] // TODO: why doing inverse logic?
            * question = "presentatie/diagnose/answer/row-0/diagnose/tnm-classificatie/answer/row-0/m-stage"
            * operator = #=
            * answerCoding = $SCT#1229901006 "M0"
          * enableWhen[+]
            * question = "presentatie/diagnose/answer/row-0/diagnose/tnm-classificatie/answer/row-0/m-stage"
            * operator = #exists
            * answerBoolean = true
          * enableBehavior = #all
          * disabledDisplay = #hidden
          * answerValueSet = Canonical(LungCancerLocationOfMetastasis)
          * answerConstraint = #optionsOrType
    * item[+]
      * insert QuestionContainer
      * linkId = "presentatie/diagnose/tnm-classificatie-mesothelioom"
      * text = "TNM classification mesothelioom"
      * code = $SCT#399566009 "TNM category"
      * enableWhen[+]
        * question = "presentatie/diagnose/answer/row-0/diagnose"
        * operator = #=
        * answerCoding = $SCT#399477001 "Mesothelioom - Sarcomatoïd"
      * enableWhen[+]
        * question = "presentatie/diagnose/answer/row-0/diagnose"
        * operator = #=
        * answerCoding = $SCT#65278006 "Mesothelioom - Epithelioïd"
      * enableBehavior = #any
      * disabledDisplay = #hidden
      * item[+]
        * insert AnswerContainer
        * linkId = "presentatie/diagnose/tnm-classificatie-mesothelioom/answer"
        * item[+]
          * insert AnswerRow
          * linkId = "presentatie/diagnose/tnm-classificatie-mesothelioom/answer/row-0"
          * item[+]
            * insert CodingDropdown
            * linkId = "presentatie/diagnose/tnm-classificatie-mesothelioom/answer/row-0/t-stage"
            * code = $SCT#399504009 "cT category"
            * text = "cT-stage"
            * answerValueSet = "http://tiro.health/fhir/ValueSet/clinical-t-stage-mesothelioma"
          * item[+]
            * insert CodingDropdown
            * linkId = "presentatie/diagnose/tnm-classificatie-mesothelioom/answer/row-0/n-stage"
            * code = $SCT#277206009 "cN category"
            * text = "cN-stage"
            * answerValueSet = "http://tiro.health/fhir/ValueSet/clinical-n-stage-mesothelioma"
          * item[+]
            * insert CodingDropdown
            * linkId = "presentatie/diagnose/tnm-classificatie-mesothelioom/answer/row-0/m-stage"
            * code = $SCT#399387003 "cM category"
            * text = "cM-stage"
            * answerValueSet = "http://tiro.health/fhir/ValueSet/clinical-m-stage-mesothelioma" 
          * item[+]
            * insert Comments
            * linkId = "presentatie/diagnose/tnm-classificatie-mesothelioom/answer/row-0/comments"
        * item[+]
          * insert QuestionContainer
          * linkId = "presentatie/diagnose/tnm-classificatie/locatie-metastase"
          * text = "Locatie van metastase"
          * code = $SCT#385421009 "Site of distant metastasis"
          * repeats = true
          * enableWhen[+] // TODO: why doing inverse logic?
            * question = "presentatie/diagnose/answer/row-0/diagnose/tnm-classificatie-mesothelioom/answer/row-0/m-stage"
            * operator = #=
            * answerCoding = $SCT#1229901006 "M0"
          * enableWhen[+]
            * question = "presentatie/diagnose/answer/row-0/diagnose/tnm-classificatie-mesothelioom/answer/row-0/m-stage"
            * operator = #exists
            * answerBoolean = true
          * enableBehavior = #all
          * disabledDisplay = #hidden
          * answerValueSet = Canonical(LungCancerLocationOfMetastasis)
          * answerConstraint = #optionsOrType


          
      
        
      
      





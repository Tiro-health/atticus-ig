Alias: $questionnaire-item-control = http://hl7.org/fhir/questionnaire-item-control
Alias: $library-type = http://terminology.hl7.org/CodeSystem/library-type
Alias: $ext-itemControl = http://hl7.org/fhir/StructureDefinition/questionnaire-itemControl
Alias: vsOrder = http://hl7.org/fhir/StructureDefinition/valueset-conceptOrder
Alias: lookup = http://hl7.org/fhir/uv/sdc/StructureDefinition/sdc-questionnaire-lookupQuestionnaire

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
    $ext-itemControl named itemControl 1..1 MS
  * extension[itemControl].valueCodeableConcept.coding = $questionnaire-item-control#list "Answer Container"
    //* valueCodeableConcept
    //  * coding[+] = $questionnaire-item-control#list
    //  * coding[+] = TiroQuestionnaireItemControl#answer-container
    //  * text = "Answer Container"


Instance: QuestionnaireRenderer
InstanceOf: Library 
Usage: #example
Title: "Questionnaire Renderer Version 3"
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

Instance: CharlsonComorbidityIndex
InstanceOf: Questionnaire 
Usage: #example
Title: "Charlson Comorbidity Calculator"
Description: "Library to calculate the Charlson Comorbidity Index"
* status = #active
* version = "1.0.0"
* name = "charlson-comorbidity-calculator"
* title = "Charlson Comorbidity Calculator"
* purpose = "Calculate the Charlson Comorbidity Index based on the input of a FHIR QuestionnaireResponse"
* publisher = "Tiro Health"

Instance: SACQ
InstanceOf: Questionnaire
Usage: #example
Title: "SACQ"
Description: "Self Administered Comorbidty Questionnaire"
* status = #active
* version = "1.0.0"
* name = "sacq"
* title = "SACQ"
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

CodeSystem: TiroQuestionnaireItemControl
Id: tiro-questionnaire-item-control
Title: "Tiro Questionnaire Item Control"
Description: "Custom Questionnaire Item Control by Tiro Health"
* #answer-container "Answer Container" "Container for answers (rows) part of a question."
* #answer-row "Answer Row" "Row of answers part of a question."
* #question-container "Question Container" "Structure to group answers and subquestions in a hierarchical tree layout."
* #comments "Comments" "Text field to add comments to a question. This component is visually more subtle than a full text field."
* #drop-down "Dropdown" "Dropdown to select a single answer from a list of options."
* #chips "Chips" "Chips to select one or more answers from a list of options."
* #text-box "Textbox" "Textbox to enter characters."
* #text-area "Text Area" "Text area to enter multiple lines of text."
* #calculator "Calculator" "Calculator to calculate a value based on a formula."

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

RuleSet: QuestionContainer
* type = #group
* extension[+]
  * url = "http://hl7.org/fhir/StructureDefinition/questionnaire-itemControl"
  * valueCodeableConcept.text = "Question Container" 
  * valueCodeableConcept.coding[0] = $questionnaire-item-control#list
  * valueCodeableConcept.coding[1] = TiroQuestionnaireItemControl#question-container

RuleSet: Comments
* type = #text
* extension[+]
  * url = "http://hl7.org/fhir/StructureDefinition/questionnaire-itemControl"
  * valueCodeableConcept.text = "Comments" 
  * valueCodeableConcept.coding[0] = $questionnaire-item-control#text
  * valueCodeableConcept.coding[1] = TiroQuestionnaireItemControl#comments

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
* #oncogenic-driver-present "oncogene driver"
* #oncogenic-driver-absent "geen oncogene driver"
* #reprofiling-weefsel-biopt "Reprofiling weefsel biopt"
* #reprofiling-liquid-biopt "Reprofiling liquid biopt"

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

ValueSet: DetectedNotDetected
Id: detected-not-detected
Title: "Detected|Not Detected"
Description: "LOINC Answer List LL744-4 for Detected|Not Detected"
* $LOINC#LA11882-0 "Detected"
  * ^extension[vsOrder].valueInteger = 0 
* $LOINC#LA11883-8 "Not Detected"
  * ^extension[vsOrder].valueInteger = 1


ValueSet: JaNee
Id: ja-nee
Title: "Ja|Nee"
Description: "SNOMED-CT codes for 'ja' and 'nee'"
* $SCT#373066001 "ja"
  * ^extension[vsOrder].valueInteger = 0 
* $SCT#373067005 "nee"
  * ^extension[vsOrder].valueInteger = 1

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
      * linkId = "presentatie/diagnose/tnm-classificatie" // merge both TNM classifications and use answerOptionsToggleExpression
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
    * item[+]
      * insert CodingChips
      * linkId = "presentatie/diagnose/mutatie"
      * text = "Mutatie"
      * code = $SCT#55446002 "Genetic mutation"
      * enableBehavior = #any
      * disabledDisplay = #hidden
      * answerOption[+].valueCoding = UZLeuvenREOAddendum#oncogenic-driver-present "oncogene driver"
      * answerOption[+].valueCoding = UZLeuvenREOAddendum#oncogenic-driver-absent "geen oncogene driver"
      * enableWhen[+]
        * question = "presentatie/diagnose/answer/row-0/diagnose"
        * operator = #=
        * answerCoding = $SCT#255725002 "NSCLC - adenocarcinoom"
      * enableWhen[+]
        * question = "presentatie/diagnose/answer/row-0/diagnose"
        * operator = #=
        * answerCoding = $SCT#723301009 "NSCLC - spinocellulair carcinoom"
      * enableWhen[+]
        * question = "presentatie/diagnose/answer/row-0/diagnose"
        * operator = #=
        * answerCoding = $SCT#1260072008 "NSCLC - sarcomatoïd carcinoom"
      * enableWhen[+]
        * question = "presentatie/diagnose/answer/row-0/diagnose"
        * operator = #=
        * answerCoding = UZLeuvenREOAddendum#nsclc-nos "NSCLC NOS"
      // TODO: add all mutations
    * item[+]
      * insert QuestionContainer
      * linkId = "presentatie/diagnose/ihc-profile"
      * text = "IHC Profile"
      * code = $SCT#1234806008 "Observation using immunohistochemistry" // TODO: check if this a correct code
      * enableBehavior = #any
      * disabledDisplay = #hidden
      * enableWhen[+]
        * question = "presentatie/diagnose/answer/row-0/diagnose"
        * operator = #=
        * answerCoding = $SCT#255725002 "NSCLC - adenocarcinoom"
      * enableWhen[+]
        * question = "presentatie/diagnose/answer/row-0/diagnose"
        * operator = #=
        * answerCoding = $SCT#723301009 "NSCLC - spinocellulair carcinoom"
      * enableWhen[+]
        * question = "presentatie/diagnose/answer/row-0/diagnose"
        * operator = #=
        * answerCoding = $SCT#1260072008 "NSCLC - sarcomatoïd carcinoom"
      * enableWhen[+]
        * question = "presentatie/diagnose/answer/row-0/diagnose"
        * operator = #=
        * answerCoding = UZLeuvenREOAddendum#nsclc-nos "NSCLC NOS"
      * item[+]
        * linkId = "presentatie/diagnose/ihc-profile/pd-l1"
        * insert DecimalTextbox(#% "%")
        * type = #quantity
        * text = "PD-L1"
        * code[+] = $SCT#1255770005 "Presence of programmed cell death 1 ligand 1 in primary malignant neoplasm of lung by immunohistochemistry"
        * code[+] = $LOINC#85147-7 "PD-L1 by clone 22C3 in Tissue by Immune stain Report"
        * item[+]
          * linkId = "presentatie/diagnose/ihc-profile/p40/comments" 
          * insert Comments
      * item[+]
        * linkId = "presentatie/diagnose/ihc-profile/p40"
        * insert CodingChips
        * text = "P40"
        * code = $LOINC#99086-1 "p40 Ag [Presence] in Tissue by Immune stain"
        * answerValueSet = Canonical(DetectedNotDetected)
        * item[+]
          * linkId = "presentatie/diagnose/ihc-profile/p40/comments" 
          * insert Comments
      * item[+]
        * linkId = "presentatie/diagnose/ihc-profile/ck7"
        * insert CodingChips
        * text = "CK7"
        * code = $LOINC#40559-7 "TTF-1 [Presence] in Tissue by Immune stain"
        * answerValueSet = Canonical(DetectedNotDetected)
        * item[+]
          * linkId = "presentatie/diagnose/ihc-profile/ck7/comments"
          * insert Comments
    * item[+]
      * linkId = "presentatie/diagnose/reprofile-weefsel-biopt"
      * insert CodingChips
      * text = "Reprofile weefsel biopt"
      * code = UZLeuvenREOAddendum#reprofiling-weefsel-biopt "Reprofiling weefsel biopt"
      * answerValueSet = Canonical(JaNee)
      * item[+]
        * linkId = "presentatie/diagnose/reprofile-weefsel-biopsie/comments"
        * insert Comments
      * item[+]
        * linkId = "presentatie/diagnose/reprofile-weefsel-biopsie/details"
        * type = #text
        * text = "Details"
    * item[+]
      * linkId = "presentatie/diagnose/reprofile-liquid-biopt"
      * insert Comments
      * text = "Reprofile liquid biopt"
      * code = UZLeuvenREOAddendum#reprofiling-liquid-biopt "Reprofiling liquid biopt"
      * answerValueSet = Canonical(JaNee)
      * item[+]
        * linkId = "presentatie/diagnose/reprofile-liquid-biopsie/comments"
        * insert Comments
      * item[+]
        * linkId = "presentatie/diagnose/reprofile-liquid-biopsie/details"
        * type = #text
        * text = "Details"
    * item[+]
      * linkId = "presentatie/diagnose/who-score"
      * insert CodingDropdown
      * text = "WHO score bij diagnose"
      * code = $SCT#373802001 "WHO performance status finding"
      * answerValueSet = "http://tiro.health/fhir/ValueSet/who-performance-score"
      * insert SupportLink(https://www.researchgate.net/profile/Ramanathan-Kasivisvanathan/publication/318503381/figure/fig2/AS:534157391601665@1504364454905/ECOG-WHO-performance-status-score-13.png)
      * item[+]
        * linkId = "presentatie/diagnose/who-score/comments"
        * insert Comments
    * item[+]
      * linkId = "presentatie/diagnose/rook-status"
      * insert CodingChips
      * text = "Rookstatus bij diagnose" 
      * code = $SCT#229819007 "Tobacco smoking status"
      * answerValueSet = "http://tiro.health/fhir/ValueSet/smoker-status"
      * item[+]
        * linkId = "presentatie/diagnose/pakjaren"
        * code = $SCT#401201003 "Pack years"
        * insert DecimalTextbox(#{PackYears} "pakjaar")
        * enableBehavior = #any
        * disabledDisplay = #protected
        * enableWhen[+]
          * question = "presentatie/diagnose/rook-status"
          * operator = #=
          * answerCoding = $SCT#8517006 "Ex-smoker"
        * enableWhen[+]
          * question = "presentatie/diagnose/rook-status"
          * operator = #=
          * answerCoding = $SCT#77176002 "Smoker"
      * item[+]
        * linkId = "presentatie/diagnose/rook-status/comments"
        * insert Comments
    * item[+]
      * linkId = "presentatie/diagnose/cci"
      * insert Calculator
      * text = "Charlson Comorbidity Index"
      * extension[+]
        * url = "http://hl7.org/fhir/uv/sdc/StructureDefinition/sdc-questionnaire-lookupQuestionnaire"
        * valueCanonical = Canonical(CharlsonComorbidityIndex)
      * item[+]
        * linkId = "presentatie/diagnose/cci/comments"
        * insert Comments
    * item[+]
      * linkId = "presentatie/diagnose/sacq"
      * insert Calculator
      * text = "Self-Administered Comorbidity Questionnaire"
      * extension[+]
        * url = "http://hl7.org/fhir/uv/sdc/StructureDefinition/sdc-questionnaire-lookupQuestionnaire"
        * valueCanonical = Canonical(SACQ)
      * item[+]
        * linkId = "presentatie/diagnose/sacq/comments"
        * insert Comments 
    * item[+]
      * linkId = "presentatie/diagnose/nierfunctie"
      * insert DecimalTextbox(#mL/min "mL/min")
      * text = "Nierfunctie"
      * code = $SCT#80274001 "Glomerular filtration rate"
    * item[+]
      * linkId = "presentatie/diagnose/longfunctie"
      * insert QuestionContainer
      * text = "Longfunctie"
      * code = $SCT#23426006 "Measurement of respiratory function"
      * item[+]
        * linkId = "presentatie/diagnose/longfunctie/answer"
        * insert AnswerContainer
        * item[+]
          * insert AnswerRow
          * linkId = "presentatie/diagnose/longfunctie/answer/row-0"
          * item[+]
            * linkId = "presentatie/diagnose/longfunctie/answer/row-0/performed"
            * insert CodingChips
            * answerOption[+].valueCoding = $SCT#398166005 "uitgevoerd"
            * answerOption[+].valueCoding = $SCT#385660001 "niet uitgevoerd"
          * item[+]
            * insert DecimalTextbox(#% "%")
            * linkId = "presentatie/diagnose/longfunctie/answer/row-0/fev1"
            * text = "FEV1"
            * code = $SCT#301965007 "Forced expiratory volume in 1 second"
            * enableWhen[+]
              * question = "presentatie/diagnose/longfunctie/answer/row-0/performed"
              * operator = #=
              * answerCoding = $SCT#398166005 "uitgevoerd"
            * disabledDisplay = #protected
          * item[+]
            * insert DecimalTextbox(#% "%")
            * linkId = "presentatie/diagnose/longfunctie/answer/row-0/dlco"
            * text = "DLCO"
            * code = $SCT#36421003 "Carbon monoxide diffusing capacity measurement"
            * enableWhen[+]
              * question = "presentatie/diagnose/longfunctie/answer/row-0/performed"
              * operator = #=
              * answerCoding = $SCT#398166005 "uitgevoerd"
            * disabledDisplay = #protected
        * item[+]
          * linkId = "presentatie/diagnose/longfunctie/answer/row-0/comments"
          * insert Comments
    * item[+]
      * linkId = "presentatie/diagnose/opmerkingen"
      * insert TextArea
      * text = "Extra opmerkingen"    
        




          
      
        
      
      





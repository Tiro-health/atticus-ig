Instance: Questionnaire
InstanceOf: Library 
Usage: #example
Title: "Questionnaire Version 3"
Description: "Render library to render a FHIR Questionnaire in a tree like question-answer layout"
* status = #active
* url = "http://tiro.health/render-type/questionnaire|v3.0.0"
* version = "3.0.0"
* type.text = "React/NPM package to render a FHIR Questionnaire"
* type.coding = http://terminology.hl7.org/CodeSystem/library-type#logic-library "Logic Library"
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

RuleSet: AnswerContainer
* type = #group

RuleSet: AnswerRow
* type = #group

RuleSet: QuestionContainer
* type = #group

RuleSet: Comments
* type = #text

RuleSet: CodingDropdown
* type = #coding

RuleSet: CodingChips
* type = #coding

CodeSystem: LungCancerDiagnosisUZLeuvenAddendum
Id: lung-cancer-diagnosis-uzleuven-addendum
Title: "Lung Cancer Diagnosis UZ Leuven Addendum"
Description: "Extra codes for the Lung Cancer Diagnosis to used during MDT meetings at UZ Leuven"
* ^content = #complete
* #nsclc-nos "NSCLC NOS" "Non-Small Cell Lung Cancer, not otherwise specified"
* #carcinoid-nos "Carcinoïd NOS" "Carcinoid, not otherwise specified"
* #carcinoma-mixed "Mixed Carcinoma" "Mixed Carcinoma"

ValueSet: LungCancerDiagnosis
Id: lung-cancer-diagnosis
Title: "Lung Cancer Diagnosis"
Description: "Diagnosis of Lung Cancer"
* ^language = #nl-BE
* $SCT#255725002 "NSCLC - adenocarcinoom"
* $SCT#723301009 "NSCLC - spinocellulair carcinoom"
* LungCancerDiagnosisUZLeuvenAddendum#nsclc-nos "NSCLC NOS"
* $SCT#1260072008 "NSCLC - sarcomatoïd carcinoom"
* $SCT#254632001 "Kleincellig longcarcinoom (SCLC)"
* $SCT#189607006 "Carcinoïd - Typisch"
* $SCT#128658008 "Carcinoïd - Atypisch"
* LungCancerDiagnosisUZLeuvenAddendum#carcinoid-nos "Carcinoïd NOS"
* $SCT#65278006 "Mesothelioom - Epithelioïd"
* $SCT#399477001 "Mesothelioom - Sarcomatoïd"
* LungCancerDiagnosisUZLeuvenAddendum#carcinoma-mixed "Mixed Carcinoma"
* $SCT#128628002 "Large cell neuroendocrine carcinoma (LCNEC)"
* $SCT#707596000 "Carcinosarcoma"
* $SCT#11671000 "Adenoïd cystisch carcinoma" 
* $SCT#373068000 "Onbekend"
* $SCT#74964007 "Andere" // this should be covered by the `Questionnaire.item.answerConstraint` field

Instance: REOPreviousProblem
InstanceOf: Questionnaire
Usage: #example
Title: "REO Previous Problem"
Description: "Previous problems overview for REO Multidisplincary Discussion"
* status = #active
* version = "5.0.1"
* language = #nl-BE
* extension[RenderType].valueCanonical = "http://tiro.health/render-type/questionnaire|v3.0.0"
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
            * text = "cT category"
            * answerValueSet = "http://tiro.health/fhir/ValueSet/clinical-t-stage-lung-cancer"
          * item[+]
            * insert CodingDropdown
            * linkId = "presentatie/diagnose/tnm-classificatie/answer/row-0/n-stage"
            * code = $SCT#277206009 "cN category"
            * text = "cN category"
            * answerValueSet = "http://tiro.health/fhir/ValueSet/clinical-n-stage-lung-cancer"
          * item[+]
            * insert CodingDropdown
            * linkId = "presentatie/diagnose/tnm-classificatie/answer/row-0/m-stage"
            * code = $SCT#399387003 "cM category"
            * text = "cM category"
            * answerValueSet = "http://tiro.health/fhir/ValueSet/clinical-m-stage-lung-cancer" 
          * item[+]
            * insert Comments
            * linkId = "presentatie/diagnose/tnm-classificatie/answer/row-0/comments"
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
            * text = "cT category"
            * answerValueSet = "http://tiro.health/fhir/ValueSet/clinical-t-stage-mesothelioma"
          * item[+]
            * insert CodingDropdown
            * linkId = "presentatie/diagnose/tnm-classificatie-mesothelioom/answer/row-0/n-stage"
            * code = $SCT#277206009 "cN category"
            * text = "cN category"
            * answerValueSet = "http://tiro.health/fhir/ValueSet/clinical-n-stage-mesothelioma"
          * item[+]
            * insert CodingDropdown
            * linkId = "presentatie/diagnose/tnm-classificatie-mesothelioom/answer/row-0/m-stage"
            * code = $SCT#399387003 "cM category"
            * text = "cM category"
            * answerValueSet = "http://tiro.health/fhir/ValueSet/clinical-m-stage-mesothelioma" 
          * item[+]
            * insert Comments
            * linkId = "presentatie/diagnose/tnm-classificatie-mesothelioom/answer/row-0/comments"
      
        
      
      





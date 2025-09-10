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

/**
 * REO Multidisciplinary Discussion Template 
 */

CodeSystem: REO 
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
* #egfr-exon-18 "ex18"
* #egfr-exon-19 "ex19"
* #egfr-exon-20-insertion "ex20 (ins)"
* #egfr-exon-20-other "ex20 (other)"
* #egfr-exon-21 "ex21"
* #egfr-amp "amp" 
* #alk-fusion "fusion"
* #alk-G1202R "G1202R"
* #alk-I1171N "I1171N"
* #alk-L1196M "L1196M"

ValueSet: LungCancerDiagnosis
Id: lung-cancer-diagnosis
Title: "Lung Cancer Diagnosis"
Description: "Diagnosis of Lung Cancer"
* ^language = #nl-BE
* $SCT#255725002 "NSCLC - adenocarcinoom"
* $SCT#723301009 "NSCLC - spinocellulair carcinoom"
* REO#nsclc-nos "NSCLC NOS"
* $SCT#1260072008 "NSCLC - sarcomatoïd carcinoom"
* $SCT#254632001 "Kleincellig longcarcinoom (SCLC)"
* $SCT#189607006 "Carcinoïd - Typisch"
* $SCT#128658008 "Carcinoïd - Atypisch"
* REO#carcinoid-nos "Carcinoïd NOS"
* $SCT#65278006 "Mesothelioom - Epithelioïd"
* $SCT#399477001 "Mesothelioom - Sarcomatoïd"
* REO#carcinoma-mixed "Mixed Carcinoma"
* $SCT#128628002 "Large cell neuroendocrine carcinoma (LCNEC)"
* $SCT#707596000 "Carcinosarcoma"
* $SCT#11671000 "Adenoïd cystisch carcinoma" 
* $SCT#373068000 "Onbekend"
* $SCT#74964007 "Andere" // this should be covered by the `Questionnaire.item.answerConstraint` field

ValueSet: ClinicalMStageLungCancerREO
Id: clinical-mstage-lung-cancer-reo
Title: "Clinical M-Stage Lung Cancer with REO Addendum"
Description: "Clinical M-Stage for Lung Cancer with REO Addendum"
* codes from valueset ClinicalMStageLungCancer 
* $SCT#1229912006 "M1c1"
* $clinical-m-stage-lung-cancer-addendum#cm1c2 "M1c2"
* $clinical-m-stage-lung-cancer-addendum#cmx "Mx"


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
* REO#extra-thoracic-lymph-nodes "extrathoracale lymfeklieren" 

ValueSet: DetectedNotDetected
Id: detected-not-detected
Title: "Detected|Not Detected"
Description: "LOINC Answer List LL744-4 for Detected|Not Detected"
* $LOINC#LA11882-0 "Detected"
  * ^extension[$vsOrder].valueInteger = 0 
* $LOINC#LA11883-8 "Not Detected"
  * ^extension[$vsOrder].valueInteger = 1

ValueSet: PositiveNegative
Id: positive-negative
Title: "Positive Negative"
Description: "Positive Negative from LOINC Answer List LL360-9"
* $LOINC#LA6576-8 "Positive"
* $LOINC#LA6577-6 "Negative"

ValueSet: JaNee
Id: ja-nee
Title: "Ja|Nee"
Description: "SNOMED-CT codes for 'ja' and 'nee'"
* $SCT#373066001 "ja"
  * ^extension[$vsOrder].valueInteger = 0 
* $SCT#373067005 "nee"
  * ^extension[$vsOrder].valueInteger = 1

Instance: REOPreviousProblem
InstanceOf: Questionnaire
Usage: #example
Title: "REO Previous Problem"
Description: "Previous problems overview for REO Multidisplincary Discussion"
* status = #active
* version = "5.0.1"
* language = #nl-BE
* extension[RenderType].valueCanonical = Canonical(TreeLayoutRenderer) 
* extension[Orientation].valueCode = #vertical
* extension[NarrativeTemplate]
  * valueExpression.language = #text/x.tiro-health.liquid
  * valueExpression.expression = "{{ subquestions | join: '\n' }}"
* item[0]
  * linkId = "presentatie"
  * text = "# Presentatie" // some syntax to automatically generate a ordinal prefix
  * type = #group
  * repeats = true
  * code = $SCT#255259006 "First presentation" // probably not the right code
  * item[+] // DATE OF DIAGNOSIS
    * linkId = "presentatie/incidentie-datum"
    * insert DateField
    * text = "IncidentieDatum"
    * code =  $SCT#432213005 "Date of diagnosis"
  * item[+] // DIAGNOSIS
    * insert CodingDropdown 
    * linkId = "presentatie/diagnose"
    * text = "Diagnose"
    * answerConstraint = #optionsOrType
    * code =  $SCT#439401001 "Diagnosis"
    * extension[$variable][+]
      * valueExpression.name = #isMesothelioma
      * valueExpression.language = #text/fhirpath
      * valueExpression.expression = "%context.repeat(item).where(linkId = 'presentatie/diagnose').answer.value.code in ('399477001', '65278006')"
    * extension[NarrativeTemplate]
      * valueExpression.language = #text/x.tiro-health.liquid
      // short cut for printing basic types needed
      * valueExpression.expression = """
        Diagnose: {{ %item.answer.value.display.join(',') }}
        {% indent 2 %}
        {{ subquestions }}
        {% endindent %}
        """
    * item[+] // SUBQUESTIONS
      * insert QuestionGroup
      * linkId = "presentatie/diagnose/primaire-tumorlokalisatie"
      * text = "Primaire tumorlokalisatie"
      * code =  $SCT#399687005 "Primary tumor site"
      // Not relevant if the diagnosis is mesothelioma
      * enableWhen[+]
        * question = "presentatie/diagnose"
        * operator = #!=
        * answerCoding = $SCT#399477001 "Mesothelioom - Sarcomatoïd"
      * enableWhen[+]
        * question = "presentatie/diagnose"
        * operator = #!=
        * answerCoding = $SCT#65278006 "Mesothelioom - Epithelioïd"
      * enableWhen[+]
        * question = "presentatie/diagnose"
        * operator = #exists
        * answerBoolean = true
      * enableBehavior = #all
      * disabledDisplay = #hidden
      * item[+]
        * linkId = "presentatie/diagnose/primaire-tumorlokalisatie/lokalisatie-links"
        * insert CodingChips
        * answerOption[+].valueCoding = $SCT#82414001 "linker long"
        * answerOption[+].valueCoding = $SCT#82407001 "linker onderkwab"
        * answerOption[+].valueCoding = $SCT#82408000 "linker bovenkwab"
      * item[+]
        * linkId = "presentatie/diagnose/primaire-tumorlokalisatie/lokalisatie-rechts"
        * insert CodingChips
        * answerOption[+].valueCoding = $SCT#64353002 "rechter onderkwab"
        * answerOption[+].valueCoding = $SCT#113250009 "rechter middenkwab"
        * answerOption[+].valueCoding = $SCT#11339004 "rechter bovenkwab"
      * item[+]
        * linkId = "presentatie/diagnose/primaire-tumorlokalisatie/lokalisatie-hoofdbronchus"
        * insert CodingChips
        * answerOption[+].valueCoding = $SCT#75245000 "hoofdbronchus Li"
        * answerOption[+].valueCoding = $SCT#70074004 "hoofdbronchus Re"
        * answerOption[+].valueCoding = $SCT#44567001 "trachea"
    * item[+] // SUBQUESTIONS
      * insert QuestionGroup
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
      * item[+]
        * linkId = "presentatie/diagnose/primaire-tumorlokalisatie-mesothelioom"
        * insert CodingChips
        * answerOption[+].valueCoding = $SCT#40768004 "links"
        * answerOption[+].valueCoding = $SCT#51872008 "rechts"
    * item[+]
      * insert QuestionGroup
      * linkId = "presentatie/diagnose/tnm-classificatie" // merge both TNM classifications and use answerOptionsToggleExpression
      * text = "TNM classificatie" 
      * code = $SCT#399566009 "TNM category"
      * enableWhen[+]
        * question = "presentatie/diagnose"
        * operator = #!=
        * answerCoding = $SCT#399477001 "Mesothelioom - Sarcomatoïd"
      * enableWhen[+]
        * question = "presentatie/diagnose"
        * operator = #!=
        * answerCoding = $SCT#65278006 "Mesothelioom - Epithelioïd"
      * enableWhen[+]
        * question = "presentatie/diagnose"
        * operator = #exists
        * answerBoolean = true
      * enableBehavior = #all
      * extension[NarrativeTemplate]
        * valueExpression.language = #text/x.tiro-health.liquid
        * valueExpression.expression = """c{{ %item.answer.value.ofType(Coding).display.join() }} ({{ subquestions }})"""
      * item[+]
        * insert CodingDropdown
        * linkId = "presentatie/diagnose/tnm-classificatie/t-stage"
        * code = $SCT#399504009 "cT category"
        * text = "cT-stage"
        * answerValueSet = Canonical(ClinicalTStageLungCancer) 
        * extension[$optionsToggle][+]
          * extension[option][+]
            * valueCoding = $SCT#1228884006 "Tis"
          * extension[option][+]
            * valueCoding = $SCT#1228891009 "T1mi"
          * extension[option][+]
            * valueCoding = $SCT#1228892002 "T1a"
          * extension[option][+]
            * valueCoding = $SCT#1228895000 "T1b"
          * extension[option][+]
            * valueCoding = $SCT#1228899006 "T1c"
          * extension[option][+]
            * valueCoding = $SCT#1228931008 "T2a"
          * extension[option][+]
            * valueCoding = $SCT#1228934000 "T2b"
          * extension[expression]
            * valueExpression.language = #text/fhirpath
            * valueExpression.expression = "not(%isMesothelioma)"
            * valueExpression.description = "Enable Tis, T1mi, T1a, T1b, T1c, T2a, T2b when not Mesothelioma"
          * extension[$optionsToggle][+]
            * extension[option][+]
              * valueCoding = $SCT#1228889001 "T1"
            * extension[option][+]
              * valueCoding = $SCT#1228929004 "T2"
            * extension[expression]
              * valueExpression.language = #text/fhirpath
              * valueExpression.expression = "%isMesothelioma"
              * valueExpression.description = "Enable T1, T2 when Mesothelioma"
      * item[+]
        * insert CodingDropdown
        * linkId = "presentatie/diagnose/tnm-classificatie/n-stage"
        * code = $SCT#277206009 "cN category"
        * text = "cN-stage"
        * answerValueSet = Canonical(ClinicalNStageLungCancer)
        * extension[$optionsToggle][+]
          * extension[option][+]
            * valueCoding = $SCT#1229981009 "N2a"
          * extension[option][+]
            * valueCoding = $SCT#1229982002 "N2b"
          * extension[option][+]
            * valueCoding = $SCT#1229984001 "N3"
          * extension[expression]
            * valueExpression.language = #text/fhirpath
            * valueExpression.expression = "not(%isMesothelioma)"
            * valueExpression.description = "Enable N2a, N2b, N3 when not Mesothelioma"
      * item[+]
        * insert CodingDropdown
        * linkId = "presentatie/diagnose/tnm-classificatie/m-stage"
        * code = $SCT#399387003 "cM category"
        * text = "cM-stage"
        * answerValueSet = Canonical(ClinicalMStageLungCancerREO)
        * extension[$optionsToggle][+]
          * extension[option][+]
            * valueCoding = $SCT#1229904003 "M1a"
          * extension[option][+]
            * valueCoding = $SCT#1229907005 "M1b"
          * extension[option][+]
            * valueCoding = $SCT#1229910003 "M1c"
          * extension[option][+]
            * valueCoding = $SCT#1229912006 "M1c1"
          * extension[option][+]
            * valueCoding = $SCT#1229912006 "M1c2"
          * extension[option][+]
            * valueCoding = $clinical-m-stage-lung-cancer-addendum#cmx "Mx"
          * extension[expression]
            * valueExpression.language = #text/fhirpath
            * valueExpression.expression = "not(%isMesothelioma)"
            * valueExpression.description = "Enable M1a, M1b, M1c, M1c1, M1c2, Mx when notMesothelioma"
        * extension[$optionsToggle][+]
          * extension[option][+]
            * valueCoding = $SCT#1229903009 "M1"
          * extension[expression]
            * valueExpression.language = #text/fhirpath
            * valueExpression.expression = "%isMesothelioma"
            * valueExpression.description = "Enable M1 when Mesothelioma"
    * item[+]
      * insert CodingChips
      * linkId = "presentatie/diagnose/tnm-classificatie/locatie-metastase"
      * text = "Locatie van metastase"
      * code = $SCT#385421009 "Site of distant metastasis"
      * repeats = true
      * extension[NarrativeTemplate]
        * valueExpression.language = #text/x.tiro-health.liquid
        * valueExpression.expression = "{{%item.answer.value.print().join(',')}}"
      * enableWhen[+] // TODO: why doing inverse logic?
        * question = "presentatie/diagnose/tnm-classificatie/m-stage"
        * operator = #=
        * answerCoding = $SCT#1229901006 "M0"
      * enableWhen[+]
        * question = "presentatie/diagnose/tnm-classificatie/m-stage"
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
      * answerOption[+].valueCoding = REO#oncogenic-driver-present "oncogene driver"
      * answerOption[+].valueCoding = REO#oncogenic-driver-absent "geen oncogene driver"
      * enableWhen[+]
        * question = "presentatie/diagnose"
        * operator = #=
        * answerCoding = $SCT#255725002 "NSCLC - adenocarcinoom"
      * enableWhen[+]
        * question = "presentatie/diagnose"
        * operator = #=
        * answerCoding = $SCT#723301009 "NSCLC - spinocellulair carcinoom"
      * enableWhen[+]
        * question = "presentatie/diagnose"
        * operator = #=
        * answerCoding = $SCT#1260072008 "NSCLC - sarcomatoïd carcinoom"
      * enableWhen[+]
        * question = "presentatie/diagnose"
        * operator = #=
        * answerCoding = REO#nsclc-nos "NSCLC NOS"
      * extension[NarrativeTemplate]
        * valueExpression.language = #text/x.tiro-health.liquid
        * valueExpression.expression = """
        {%- if item.answer.value.code == 'oncogenic-driver-present' %}
        Mutaties: {{ subquestions | split: '\n' | join: '; '}}
        {%- endif %}
        """
      * item[+]
        * linkId = "presentatie/diagnose/mutatie/egfr"
        * insert CodingChips
        * text = "EGFR"
        * code = $CLINVAR#HGNC:3236 "EGFR"
        * answerValueSet = Canonical(PositiveNegative)
        * extension[NarrativeTemplate]
          * valueExpression.language = #text/x.tiro-health.liquid
          * valueExpression.expression = """
          {%- if %item.answer.value.code == 'LA6576-8' #present %}
          {{ %item.answer.value.print().join(' ')}}
          {%- endif %}
          """
        * item[+]
          * linkId = "presentatie/diagnose/mutatie/egfr/exon"
          * insert CodingChips
          * repeats = true
          * answerOption[+].valueCoding = REO#egfr-exon-18 "ex18"
          * answerOption[+].valueCoding = REO#egfr-exon-19 "ex19"
          * answerOption[+].valueCoding = REO#egfr-exon-20-insertion "ex20 (ins)"
          * answerOption[+].valueCoding = REO#egfr-exon-20-other "ex20 (other)"
          * answerOption[+].valueCoding = REO#egfr-exon-21 "ex21"
      * item[+]
        * linkId = "presentatie/diagnose/mutatie/alk"
        * insert CodingChips
        * code = $CLINVAR#HGNC:427 "ALK"
        * text = "ALK"
        * repeats = true
        * answerValueSet = Canonical(PositiveNegative)
        * extension[NarrativeTemplate]
          * valueExpression.language = #text/x.tiro-health.liquid
          * valueExpression.expression = """
          {%- if item.answer.value.code == 'LA6576-8' #present %}
          {{ %item.answer.value.print().join(' ')}}
          {%- endif %}
          """
        * item[+]
          * linkId = "presentatie/diagnose/mutatie/alk/co-mutatie" 
          * insert CodingChips
          * answerOption[+].valueCoding = REO#alk-fusion "fusion"
          * answerOption[+].valueCoding = REO#alk-G1202R "G1202R"
          * answerOption[+].valueCoding = REO#alk-I1171N "I1171N"
          * answerOption[+].valueCoding = REO#alk-L1196M "L1196M"
      * item[+]
        * linkId = "presentatie/diagnose/mutatie/ros1"
        * insert CodingChips
        * code = $CLINVAR#HGNC:10261 "ROS1"
        * text = "ROS1"
      * item[+]
        * linkId = "presentatie/diagnose/mutatie/kras"
        * insert CodingChips
        * code = $CLINVAR#HGNC:6407 "KRAS"
        * text = "KRAS"
      * item[+]
        * linkId = "presentatie/diagnose/mutatie/braf"
        * insert CodingChips
        * code = $CLINVAR#HGNC:1097 "BRAF"
        * text = "BRAF"
      * item[+]
        * linkId = "presentatie/diagnose/mutatie/ret"
        * insert CodingChips
        * code = $CLINVAR#HGNC:9967 "RET"
      * item[+]
        * linkId = "presentatie/diagnose/mutatie/her2"
        * insert CodingChips
        * code = $CLINVAR#HGNC:28871 "HER2"
      * item[+]
        * linkId = "presentatie/diagnose/mutatie/met"
        * insert CodingChips
        * code = $CLINVAR#HGNC:7029 "MET"
      * item[+]
        * linkId = "presentatie/diagnose/mutatie/ntrk"
        * insert CodingChips
        * code = $CLINVAR#HGNC:8031 "NTRK"
      * item[+]
        * linkId = "presentatie/diagnose/mutatie/nrg1"
        * insert CodingChips
        * code = $CLINVAR#HGNC:7997 "NRG1"
      * item[+]
        * linkId = "presentatie/diagnose/mutatie/pik3ca"
        * insert CodingChips
        * code = $CLINVAR#HGNC:8975 "PIK3CA"
      * item[+]
        * linkId = "presentatie/diagnose/mutatie/rb1"
        * insert CodingChips
        * code = $CLINVAR#HGNC:9884 "RB1"
    * item[+]
      * insert QuestionGroup
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
        * answerCoding = REO#nsclc-nos "NSCLC NOS"
      * item[+]
        * linkId = "presentatie/diagnose/ihc-profile/pd-l1"
        * insert DecimalTextbox(#% "%")
        * type = #quantity
        * text = "PD-L1"
        * code[+] = $SCT#1255770005 "Presence of programmed cell death 1 ligand 1 in primary malignant neoplasm of lung by immunohistochemistry"
        * code[+] = $LOINC#85147-7 "PD-L1 by clone 22C3 in Tissue by Immune stain Report"
      * item[+]
        * linkId = "presentatie/diagnose/ihc-profile/p40"
        * insert CodingChips
        * text = "P40"
        * code = $LOINC#99086-1 "p40 Ag [Presence] in Tissue by Immune stain"
        * answerValueSet = Canonical(DetectedNotDetected)
      * item[+]
        * linkId = "presentatie/diagnose/ihc-profile/ck7"
        * insert CodingChips
        * text = "CK7"
        * code = $LOINC#40559-7 "TTF-1 [Presence] in Tissue by Immune stain"
        * answerValueSet = Canonical(DetectedNotDetected)
    * item[+]
      * linkId = "presentatie/diagnose/reprofile-weefsel-biopt"
      * insert CodingChips
      * text = "Reprofile weefsel biopt"
      * code = REO#reprofiling-weefsel-biopt "Reprofiling weefsel biopt"
      * answerValueSet = Canonical(JaNee)
      * item[+]
        * linkId = "presentatie/diagnose/reprofile-weefsel-biopsie/details"
        * type = #text
        * text = "Details"
    * item[+]
      * insert CodingChips
      * linkId = "presentatie/diagnose/reprofile-liquid-biopt"
      * text = "Reprofile liquid biopt"
      * code = REO#reprofiling-liquid-biopt "Reprofiling liquid biopt"
      * answerValueSet = Canonical(JaNee)
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
      * linkId = "presentatie/diagnose/cci"
      * insert Calculator
      * text = "Charlson Comorbidity Index"
      * extension[+]
        * url = "http://hl7.org/fhir/uv/sdc/StructureDefinition/sdc-questionnaire-lookupQuestionnaire"
        * valueCanonical = Canonical(CharlsonComorbidityIndex)
    * item[+]
      * linkId = "presentatie/diagnose/sacq"
      * insert Calculator
      * text = "Self-Administered Comorbidity Questionnaire"
      * extension[+]
        * url = "http://hl7.org/fhir/uv/sdc/StructureDefinition/sdc-questionnaire-lookupQuestionnaire"
        * valueCanonical = Canonical(SACQ)
    * item[+]
      * linkId = "presentatie/diagnose/nierfunctie"
      * insert DecimalTextbox(#mL/min "mL/min")
      * text = "Nierfunctie"
      * code = $SCT#80274001 "Glomerular filtration rate"
    * item[+]
      * linkId = "presentatie/diagnose/longfunctie"
      * insert QuestionGroup
      * text = "Longfunctie"
      * code = $SCT#23426006 "Measurement of respiratory function"
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
      * linkId = "presentatie/diagnose/opmerkingen"
      * insert TextArea
      * text = "Extra opmerkingen"    

Extension: InitialValueTemplate
Id: initial-value-template
Title: "Initial Value Template"
Description: "Set of initial values for a questionnaire"
Context: Questionnaire.item
* extension contains
  name 1..1 MS and
  item 0..* MS
* extension[name] ^short = "Name of the template"
* extension[name].value[x] only string
* extension[item] ^short = "Answer values for the template"
* extension[item].extension contains
  linkId 1..1 MS and
  answer 1..1 MS
* extension[item].extension[linkId] ^short = "LinkId of the item"
* extension[item].extension[linkId].value[x] only string
* extension[item].extension[answer] ^short = "Answer value for the item"
* extension[item].extension[answer].value[x] 1.. MS


Instance: REOPreviousTherapies
InstanceOf: Questionnaire
Usage: #example
Title: "REO Previous Therapies"
Description: "Previous therapies overview for REO Multidisplincary Discussion"
* status = #active
* version = "4.0.0"
* language = #nl-BE
* insert QuestionnaireV3
* extension[Orientation].valueCode = #vertical
* item[0]
  * linkId = "record"
  * type = #group
  * repeats = true
  * extension[InitialValueTemplate][+]
    * extension[name].valueString = "radiotherapie"
    * extension[item][+]
      * extension[linkId].valueString = "record/behandeling"
      * extension[answer].valueCoding = $SCT#429858000 "Radiotherapy"
  * extension[InitialValueTemplate][+]
    * extension[name].valueString = "systeemtherapie"
    * extension[item][+]
      * extension[linkId].valueString = "record/behandeling"
      * extension[answer].valueCoding = $SCT#429840000 "Systemic therapy"
  * extension[InitialValueTemplate][+]
    * extension[name].valueString = "chirurgie"
    * extension[item][+]
      * extension[linkId].valueString = "record/behandeling"
      * extension[answer].valueCoding = $SCT#429840000 "Surgery"
  * item[+]
    * linkId = "record/therapie-lijn"
    * insert CodingDropdown
    * text = "#"
    * answerValueSet = "http://tiro.health/fhir/CodeSystem/reo-line-of-therapy/vs"
  * item[+]
    * linkId = "record/period"
    * type = #group
    * text = "Periode"
  * item[+]
    * linkId = "record/behandeling"
    * insert CodingDropdown
    * text = "Therapie"
    * answerValueSet = "http://tiro.health/fhir/ValueSet/therapy"
    * readOnly = true
  * item[+]
    * linkId = "record/omschrijving"
    * text = "Omschrijving"
    * insert TextArea
  * item[+]
    * linkId = "record/specificatie"
    * type = #group
    * text = "Specificatie"
    * item[+]
      * linkId = "record/specificatie/radiotherapie"
      * type = #group
      * item[+]
        * linkId = "record/specificatie/radiotherapie/bestralingsdosis"
        * type = #group
        * item[+]
          * linkId = "record/specificatie/radiotherapie/bestralingsdosis/factie"
          * insert DecimalTextbox(#{Sessions} "")
        * item[+]
          * linkId = "record/specificatie/radiotherapie/bestralingsdosis/fractie-dosis"
          * insert DecimalTextbox(#{Dose} "Gy")
    * item[+]
      * linkId = "record/specificatie/systeemtherapie"
      * type = #group
      * item[+]
        * linkId = "record/specificatie/systeemtherapie/recist"
        * insert CodingDropdown
        * text = "RECIST"
        * answerValueSet = "http://tiro.health/fhir/CodeSystem/recist-nl/vs"
    * item[+]
      * linkId = "record/specificatie/chirurgie"
      * type = #group
      * enableBehavior = #any
      * enableWhen[+]
        * question = "record/behandeling"
        * operator = #=
        * answerCoding = $SCT#429840000 "Surgery"
      * item[+]
        * linkId = "record/specificatie/chirurgie/p-tnm"
        * type = #group
        * item[+]
          * linkId = "record/specificatie/chirurgie/p-tnm/t"
          * insert CodingDropdown
          * text = "pT"
          * answerValueSet = "http://tiro.health/fhir/ValueSet/p-t-stage"
        * item[+]
          * linkId = "record/specificatie/chirurgie/p-tnm/n"
          * insert CodingDropdown
          * text = "pN"
          * answerValueSet = "http://tiro.health/fhir/ValueSet/p-n-stage"
        * item[+]
          * linkId = "record/specificatie/chirurgie/p-tnm/m"
          * insert CodingDropdown
          * text = "pM"
          * answerValueSet = "http://tiro.health/fhir/ValueSet/p-m-stage"
        * item[+]
          * linkId = "record/specificatie/chirurgie/p-tnm/p-r-stage"
          * insert CodingChips
          * text = "pR"
          * answerValueSet = "http://tiro.health/fhir/ValueSet/p-r-stage"
       
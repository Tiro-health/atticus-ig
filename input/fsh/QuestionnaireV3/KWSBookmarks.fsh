Alias: $ExtLaunchContext = http://hl7.org/fhir/uv/sdc/StructureDefinition/sdc-questionnaire-launchContext
Alias: $CSLaunchContext = http://hl7.org/fhir/uv/sdc/CodeSystem/launchContext
Alias: $ExtInitialExpression = http://hl7.org/fhir/uv/sdc/StructureDefinition/sdc-questionnaire-initialExpression

CodeSystem: KWSQuestionnaireLaunchContext
Id: kwsquestionnaire-launch-context
Title: "KWS Questionnaire Launch Context"
Description: "Additional launch context for FHIR Questionnaires launched from KWS."
* #nxh-bookmarks "Bookmarks" "Launch Questionnaire with a list of KWS bookmarks wrapped in a Basic resource."

CodeSystem: KWSBookmark
Id: kws-bookmark
Title: "KWS Bookmark"
Description: "A bookmark for KWS resources."
* #KWS_PID_DeHeerOfMevrouw
* #KWS_PID_HemOfHaar
* #KWS_PID_HijOfZij
* #KWS_PID_Inschrijvingsnummer
* #KWS_PID_PatientOfPatiente
* #KWS_PID_ZijnOfHaar
* #KWS_PID_adres
* #KWS_PID_deHeerOfMevrouw
* #KWS_PID_districtOfStaat
* #KWS_PID_eadnr
* #KWS_PID_emdnr
* #KWS_PID_email
* #KWS_PID_geslacht
* #KWS_PID_gebDatum
* #KWS_PID_voornaam
* #KWS_PID_familienaam

ValueSet: KWSBookmarkValueSet
Id: kwsbookmark-value-set
Title: "KWS Bookmark Value Set"
Description: "All available bookmarks for Questionnaire population."
* include codes from system KWSBookmark

Extension: BookmarkLaunchContext
Id: bookmark-launch-context
Title: "Bookmark Launch Context"
Description: "List of bookmarks that must be available in the launch context."
Context: $ExtLaunchContext
* value[x] only code
* valueCode from KWSBookmarkValueSet
* value[x] 1..

Instance: QuestionnaireWithBookmarks
InstanceOf: Questionnaire
Usage: #example
Title: "QuestionnaireWithBookmarks"
Description: "A basic questionnaire with launch context referring to bookmarks."
* id = "random-questionnaire-id-123"
* status = #active
* title = "Questionnaire with Bookmarks"
* extension[$ExtLaunchContext][+] // mention "bookmark"
  * extension[name].valueCoding = KWSQuestionnaireLaunchContext#nxh-bookmarks "Bookmarks"
  * extension[type].valueCode = #Basic
  * extension[description].valueString = "Basic resources with bookmarks added as extensions."
  * extension[BookmarkLaunchContext][+].valueCode = #KWS_PID_voornaam
  * extension[BookmarkLaunchContext][+].valueCode = #KWS_PID_familienaam
  * extension[BookmarkLaunchContext][+].valueCode = #KWS_PID_geslacht
* extension[$ExtLaunchContext][+]
  * extension[name].valueCoding = $CSLaunchContext#encounter "Encounter"
  * extension[type].valueCode = #Encounter
  * extension[description].valueString = "The encounter in which the questionnaire was launched."
* extension[$ExtLaunchContext][+]
  * extension[name].valueCoding = $CSLaunchContext#patient "Patient"
  * extension[type].valueCode = #Patient
  * extension[description].valueString = "The patient for whom the questionnaire was launched."
* item[+]
  * linkId = "01912832-4eb9-7779-83b5-c627c7a46d72"
  * text = "Voornaam:"
  * type = #string
  * required = true
  * extension[$ExtInitialExpression].valueExpression
    * language = #text/fhirpath
    * expression = "%nxh-bookmarks.where(extension('http://fhir.tiro.health/StructureDefinition/Bookmark').extension('name') = 'KWS_PID_voornaam').extension('value').valueString"
* item[+]
  * linkId = "01912832-d2e8-74ba-8633-580664f78391"
  * text = "Familienaam"
  * type = #string
  * required = true
  * extension[$ExtInitialExpression].valueExpression
    * language = #text/fhirpath    
    * expression = "%nxh-bookmarks.where(extension('http://fhir.tiro.health/StructureDefinition/Bookmark').extension('name') = 'KWS_PID_familienaam').extension('value').valueString"
* item[+]
  * linkId = "01912832-fa91-7ae6-95d5-9afea0d0a47a"
  * text = "Geslacht"
  * type = #string
  * required = true
  * extension[$ExtInitialExpression].valueExpression
    * language = #text/fhirpath    
    * expression = "%nxh-bookmarks.where(extension('http://fhir.tiro.health/StructureDefinition/Bookmark').extension('name') = 'KWS_PID_geslacht').extension('value').valueString"

Instance: ConclusionQuestionnaire
InstanceOf: Questionnaire
Usage: #example
Title: "Conclusion Questionnaire"
Description: "A questionnaire to conclude the report."
* id = "random-questionnaire-id-321"
* status = #active
* title = "Conclusion"
* item[+]
  * linkId = "01912832-4eb9-7779-83b5-c627c7a46d72"
  * text = "Conclusie"
  * type = #text
  * item[+]
    * linkId = "01912945-8d7b-76b9-b22f-cda513fedfc3"
    * type = #coding
    * answerValueSet = "http://hl7.org/fhir/uv/sdc/ValueSet/sdc-valueset-observation-interpretation"
    * required = true

Alias: cnr = https://fhir.nexuzhealth.com/standards/fhir/NamingSystem/kws/bifrost/receptie/cnr
Alias: eadnr = https://fhir.nexuzhealth.com/standards/fhir/NamingSystem/kws/pm/patient/eadnr
Alias: verstreknr = https://fhir.nexuzhealth.com/standards/fhir/NamingSystem/kws/amalthea/basVerstrekker/verstreknr

Extension: Bookmark
Id: Bookmark
Title: "Bookmark"
Description: "A bookmark extension"
Context: Basic
* extension contains 
  name 1..1 MS and
  value 1..1 MS
* extension[name].value[x] only code

RuleSet: Bookmark(name, value)
* extension[Bookmark][+]
  * extension[name].valueCode = #{name}
  * extension[value].valueString = "{value}"

Instance: JanJansens
InstanceOf: Patient
Usage: #example
Title: "Jan Jansens"
Description: "A patient named Jan Jansens"
* id = "random-patient-id-123"
* identifier[+]
  * system = eadnr
  * value = "123456"
* name[+]
  * family = "Jansens"
  * given[+] = "Jan"
* gender = #male
* birthDate = "1970-01-01"

Instance: JanJansensContact
InstanceOf: Encounter
Usage: #example
Title: "Jan Jansens Contact"
Description: "An ongoing encounter with Jan Jansens"
* id = "random-encounter-id-123"
* identifier[+]
  * system = cnr
  * value = "123456"
* plannedStartDate = "2024-06-22"
* plannedEndDate = "2024-06-22"
* status = #in-progress
* participant
  * actor = Reference(JanJansens)
  * type = #patient 

Instance: DrPauwels
InstanceOf: Practitioner
Usage: #example
Title: "Dr. Pauwels"
Description: "A practitioner named Dr. Pauwels"
* id = "random-practitioner-id-123"
* identifier[+]
  * system = verstreknr
  * value = "123456"
* name[+]
  * family = "Pauwels"
  * given[+] = "Dr."

Instance: AbdominalSurgeon
InstanceOf: PractitionerRole
Usage: #example
Title: "Abdominal Surgeon"
Description: "A practitioner role for an abdominal surgeon"
* identifier[+]
  * system = verstreknr
  * value = "123456"
* practitioner = Reference(DrPauwels)
* code
  * text = "Abdominal Surgeon"
  * coding[+]
    * system = $SCT
    * code = #309376005
    * display = "GI surgeon"

Instance: BookmarkSnapshot
InstanceOf: Basic
Usage: #example
Title: "Bookmark Snapshot"
Description: "A snapshot of KWS bookmarks"
* id = "random-bookmarks-id-123"
* code.text = "KWS Bookmarks"
* subject = Reference(JanJansens)
* created = "2024-06-22"
* insert Bookmark(KWS_PID_VOORNAAM, Jan)
* insert Bookmark(KWS_PID_ACHTERNAAM, Janssens)
* insert Bookmark(KWS_PID_GESLACHT, man)

Instance: Session
InstanceOf: Parameters
Usage: #example
Title: "Session"
Description: "A session to launch a questionnaire."
* parameter[+]
  * name = "patient"
  * valueString = "random-patient-id-123"
* parameter[+]
  * name = "encounter"
  * valueString = "random-encounter-id-123"
* parameter[+]
  * name = "fhirContext"
  * part[+]
    * name = "reference"
    * valueString = "Basic/random-bookmarks-id-123"
  * part[+]
    * name = "role"
    * valueString = "https://tiro.health/smart/role/nxh-bookmarks-for-launch-context"
* parameter[+]
  * name = "fhirContext"
  * part[+]
    * name = "reference"
    * valueString = "Questionnaire/random-questionnaire-id-123"
  * part[+]
    * name = "role"
    * valueString = "https://tiro.health/smart/role/questionnaire-to-render"
* parameter[+]
  * name = "fhirContext"
  * part[+]
    * name = "reference"
    * valueString = "Composition/random-report-id-321"
    * name = "role"
    * valueString = "https://tiro.health/smart/role/inital-report"

Instance: InitialReport
InstanceOf: Composition
Usage: #example
Title: "Initial Report"
Description: "An initial report to be filled in."
* id = "random-report-id-321"
* status = #registered
* type.text = "Initial Report"
* subject = Reference(JanJansens)
* encounter = Reference(JanJansensContact)
* author = Reference(DrPauwels)
* date = "2024-06-22"
* title = "Initial Report"


Instance: ReportPopulationBundle
InstanceOf: Bundle 
Usage: #example
Title: "Report Population Bundle"
Description: "A bundle containing a resources to populate the report."
* type = #batch
* entry[+]
  * request.method = #POST
  * request.url = "Patient"
  * request.ifNoneExist = "identifier=https://fhir.nexuzhealth.com/standards/fhir/NamingSystem/kws/pm/patient/eadnr|123456"
  * resource = JanJansens
* entry[+]
  * request.method = #POST
  * request.url = "Encounter"
  * request.ifNoneExist = "identifier=https://fhir.nexuzhealth.com/standards/fhir/NamingSystem/kws/bifrost/receptie/cnr|123456"
  * resource = JanJansensContact
* entry[+]
  * request.method = #POST
  * request.url = "Practitioner"
  * request.ifNoneExist = "identifier=https://fhir.nexuzhealth.com/standards/fhir/NamingSystem/kws/amalthea/basVerstrekker/verstreknr|123456"
  * resource = DrPauwels
* entry[+]
  * request.method = #POST
  * request.url = "PractitionerRole"
  * request.ifNoneExist = "identifier=https://fhir.nexuzhealth.com/standards/fhir/NamingSystem/kws/amalthea/basVerstrekker/verstreknr|123456"
  * resource = AbdominalSurgeon
* entry[+]
  * request.method = #POST
  * request.url = "Basic"
  * resource = BookmarkSnapshot
* entry[+]
  * request.method = #POST
  * request.url = "Composition"
  * resource = InitialReport 

Instance: Response
InstanceOf: QuestionnaireResponse
Usage: #example
Title: "Response"
Description: "A response to the questionnaire."
* status = #completed
* authored = "2024-06-22"
* author = Reference(AbdominalSurgeon)
* subject = Reference(JanJansens)
* encounter = Reference(JanJansensContact)
* questionnaire = Canonical(QuestionnaireWithBookmarks)
* item[+]
  * linkId = "01912832-4eb9-7779-83b5-c627c7a46d72"
  * answer[+]
    * valueString = "Jan"
* item[+]
  * linkId = "01912832-d2e8-74ba-8633-580664f78391"
  * answer[+]
    * valueString = "Jansens"
* item[+]
  * linkId = "01912832-fa91-7ae6-95d5-9afea0d0a47a"
  * answer[+]
    * valueString = "man"


Instance: FilledReport
InstanceOf: Composition
Usage: #example
Title: "FilledReport"
Description: "A filled report."
* id = "random-report-id-321-final"
* status = #final
* type.text = "Some Report"
* subject = Reference(JanJansens)
* encounter = Reference(JanJansensContact)
* author = Reference(DrPauwels)
* date = "2024-06-22"
* title = "Some Report"
* section[+]
  * title = "Questionnaire with Bookmarks"
  * text.status = #generated
  * text.div = """
    <div xmlns="http://www.w3.org/1999/xhtml">
      <p>Voornaam: Jan</p>
      <p>Familienaam: Jansens</p>
      <p>Geslacht: Man</p>
    </div>
    """
  * entry[+] = Reference(Response)
  * entry[+] = Reference(BookmarkSnapshot)
  

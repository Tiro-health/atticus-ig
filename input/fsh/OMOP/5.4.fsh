Logical: OMOPRecord
Parent: Base
Id: OMOPRecord
Title: "OMOP Record"
Description: "Base model for a OMOP-CDM 5.4."
* id 1..1 id "Primary key of the table."

Logical: OMOPPerson 
Parent: OMOPRecord
Id: OMOPPerson
Characteristics: #can-be-target
Title: "OMOP Person"
Description: "Model resembling the OMOP-CDM 5.4 Person table."
* gender 1..1 Coding "Gender of the person."
* gender ^alias = "gender"
* yearOfBirth 1..1 integer "Year of birth of the person."
* yearOfBirth ^alias = "year_of_birth"
* monthOfBirth 0..1 integer "Month of birth of the person."
* monthOfBirth ^alias = "month_of_birth"
* dayOfBirth 0..1 integer "Day of birth of the person."
* dayOfBirth ^alias = "day_of_birth"
* birthDate 0..1 dateTime "Exact datetime of birth of the person."
* birthDate ^alias = "birth_date"
* race 0..1 Coding "Race of the person"

Logical: OMOPProvider
Parent: OMOPRecord
Id: OMOPProvider
Characteristics: #can-be-target
Title: "OMOP Provider"
Description: "Model resembling the OMOP-CDM 5.4 Provider table."
* providerName 1..1 string "Name of the provider."
* providerName ^alias = "provider_name"

Logical: OMOPObservation
Parent: OMOPRecord
Id: OMOPObservation
Title: "OMOP Observation"
Description: "Model resembling the OMOP-CDM 5.4 Observation table."
* patient 1..1 Reference(OMOPPerson) "Patient associated with the observation."
* coding 1..1 Coding "Concept associated with the observation."
* coding ^alias[0] = "observation_concept"
* date[x] 1..1 date or dateTime "Date of the observation."
* observationType 1..1 Coding "Type of observation."
* value[x] 0..1 decimal or string or Coding "Value of the observation."
* qualifier 0..1 Coding "Qualifier associated with the observation."
* unit 0..1 Coding "Unit associated with the observation."
* provider 0..1 Reference(OMOPProvider) "Provider associated with the observation."
//* visit_occurrence_id 0..1 id "Visit associated with the observation."
//* visit_detail_id 0..1 id "Visit detail associated with the observation."
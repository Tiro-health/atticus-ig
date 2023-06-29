Logical: OMOPRecord
Parent: Base
Id: OMOPRecord
Title: "OMOP Record"
Description: "Base model for a OMOP-CDM 5.4."
* id 1..1 id "Primary key of the table."

Logical: OMOPPerson 
Parent: OMOPRecord
Id: OMOPPerson
Title: "Person"
Description: "Model resembling the OMOP-CDM 5.4 Person table."
* gender 1..1 Coding "Gender of the person."
* year_of_birth 1..1 integer "Year of birth of the person."
* month_of_birth 0..1 integer "Month of birth of the person."
* day_of_birth 0..1 integer "Day of birth of the person."
* birth_datetime 0..1 dateTime "Exact datetime of birth of the person."
* race 0..1 Coding "Race of the person"

Logical: OMOPProvider
Parent: OMOPRecord
Id: OMOPProvider
Title: "OMOP Provider"
Description: ""
* provider_name 1..1 string "Name of the provider."

Logical: OMOPObservation
Parent: OMOPRecord
Id: OMOPObservation
Title: "OMOP Observation"
Description: "Model resembling the OMOP-CDM 5.4 Observation table."
* patient 1..1 Reference(OMOPPerson) "Patient associated with the observation."
* observation_concept 1..1 Coding "Concept associated with the observation."
* observation_date 1..1 date "Date of the observation."
* observation_datetime 1..1 dateTime "Date and time of the observation."
* observation_type 1..1 Coding "Type of observation."
* value_as_number 0..1 decimal "Numeric value of the observation."
* value_as_string 0..1 string "String value of the observation."
* value_as_concept 0..1 Coding "Concept value of the observation."
* qualifier_concept 0..1 Coding "Qualifier associated with the observation."
* unit_concept 0..1 Coding "Unit associated with the observation."
* provider 0..1 Reference(OMOPProvider) "Provider associated with the observation."
* visit_occurrence_id 0..1 id "Visit associated with the observation."
* visit_detail_id 0..1 id "Visit detail associated with the observation."
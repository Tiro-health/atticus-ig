Profile: LabMeasurement
Parent: ObservationDefinition
Description: "A measurement of a laboratory test."
* code 1..1 MS
* permittedDataType = #Quantity
* permittedUnit 1..* MS


Instance: PSA
InstanceOf: LabMeasurement
Usage: #example
Title: "PSA"
Description: "PSA is a measurement of the prostate specific antigen in a blood sample."
* status = #draft
* code =  $SCT#63476009 "Prostate-specific antigen (PSA) measurement (observable entity)"
* permittedUnit[0] = UCUM#ng/mL "nanogram per milliliter"
* permittedUnit[+] = UCUM#g/L "gram per liter"

//Instance: Hemoglobin
//InstanceOf: LabMeasurement
//Usage: #example
//Title: "Hemoglobin"
//Description: "Hemoglobin is a measurement of the hemoglobin in a blood sample."
//* status = #draft
//* code =  $SCT#104718002 "Hemoglobin, free measurement (procedure)"
//* permittedUnit[0] = UCUM#g/dL "milligram per deciliter"
//* permittedUnit[+] = UCUM#g/L "gram per liter"

Instance: DrHause
InstanceOf: Practitioner 
Usage: #example
Title: "Dr. Hause"
Description: "Example medical doctor specialized in urology/oncology"

Instance: PCaPatient
InstanceOf: Patient
Usage: #example
Title: "Prostate Cancer Patient"
Description: "Example patient that is diagnosed with prostate cancer."
* identifier.value = "8242"
* identifier.system = "http://hospital.be/official-patient-id"
* gender = #male
* birthDate = "2023-04-06"

Instance: RaisedPSAEncounter
InstanceOf: Encounter
Usage: #example
Title: "Raised PSA Encounter"
Description: "Example encounter where a patient has a raised PSA level."
* status = #in-progress
* subject = Reference(PCaPatient)
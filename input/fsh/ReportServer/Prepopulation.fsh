Instance: PCaMDT
InstanceOf: GraphDefinition
Usage: #example
Title: "Prostate Cancer MDT"
Description: "Defines the set of resources to created during the MDT Prostate Cancer."
* name = "PCaMDT"
* status = #draft
* date = 2023-05-31
* node[0]
  * nodeId = "patient"
  * description = "The subject of the MDT"
  * type = #Patient
* node[1]
  * nodeId = "psa"
  * description = "PSA measurement of the patient"
  * type = #Observation
* node[2]
  * nodeId = "biopsy"
  * description = "Biopsy of the patient"
  * type = #DiagnosticReport
* link[0]
  * sourceId = "psa"
  * path = "subject"
  * targetId = "patient"
* link[1]
  * sourceId = "biopsy"
  * path = "subject"
  * targetId = "patient"
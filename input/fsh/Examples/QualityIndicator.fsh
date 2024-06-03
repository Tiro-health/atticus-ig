Profile: QualityIndicator
Parent: Measure
Id: quality-indicator
Title: "Quality Indicator"
Description: """A Quality Indicator is a measure of the clinical quality of a service or intervention. 
Typically it is part of the nominator in Value-Based Healthcare model."""
* url MS
* title MS
* name MS


Instance: FUafterMOC
InstanceOf: QualityIndicator 
Usage: #example
Title: "Follow-up after TURB"
Description: "Percentage of patients with a TURB procedure for bladder cancer who have a MOC or Follow-up containing anatomical pathology report with a diagnosis of bladder cancer within 6 months after the TURB procedure."
* name = "FUafterMOC"
* status = #draft
* group.population[+]
  * code = #numerator
  * description = "TURB procedures followed by a MOC or Follow-up containing anatomical pathology report with a diagnosis of bladder cancer"
* group.population[+]
  * code = #denominator
  * description = """TURB procedures
  The following procedures are excluded:
  - TURB procedures with a specified reason of 'after previous instillation' (='na voorgaande instillatie')
  - Absence of the following fields: `supervisor`, `afdeling` or `eadnr`
  """
* group.stratifier[+] // These correspond to the filters in the dashboard
  * description = "Hospital"
* group.stratifier[+]
  * description = "Time period between TURB and MOC/Follow-up"
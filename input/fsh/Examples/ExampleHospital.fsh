Instance: ExampleHospital
InstanceOf: Organization
Usage: #example
Title: "Example Hospital"
Description: "This is an example hospital."
* name = "Example Hospital"

CodeSystem: ReportSections
Id: report-sections
Title: "Report Sections"
Description: "This CodeSystem defines the sections of a report as they are coded in the EHR of ExampleHospital."
* ^status = #active
* ^content = #complete
* ^experimental = false
* ^caseSensitive = true
* #medical-history "Medical history section"
* #prostate-history "Prostate history section"
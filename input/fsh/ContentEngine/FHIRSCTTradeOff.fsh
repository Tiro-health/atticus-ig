Instance: DemoPatient
InstanceOf: Patient
Usage: #example
Title: "Demo Patient"
Description: "Patiënt for illustration purposes."
* name.given[0] = "Eve"
* name.family = "Anyperson"

Instance: URSboTCC
InstanceOf: Procedure
Usage: #example
Title: "URS because of TCC"
Description: "Ureterenoscopie because of a TCC"
* status = #done
* category = $SCT#387713003 "Surgical procedure (procedure)"
* code.text = "URS because of TCC"
* code.coding[0] = $SCT#386787002 "ureterorenoscopie"
* subject = Reference(DemoPatient)
* reason.concept.text = "TCC"
* reason.concept.coding[0] = $SCT#255109008 "overgangscelcarcinoom van blaas"

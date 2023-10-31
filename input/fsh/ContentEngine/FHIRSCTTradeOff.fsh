Instance: DemoPatient
InstanceOf: Patient
Usage: #example
Title: "Demo Patient"
Description: "Patiënt for illustration purposes."
* name.given[0] = "Eve"
* name.family = "Anyperson"

Instance: URSboTCC1
InstanceOf: Procedure
Usage: #example
Title: "URS because of TCC"
Description: "Ureterenoscopie because of a TCC"
* status = #done
* code.text = "URS because of TCC"
* code.coding[0] = $SCT#38678700:2363702006=255109008 "Uretorenoscopy"
* subject = Reference(DemoPatient)

Instance: URSboTCC2
InstanceOf: Procedure
Usage: #example
Title: "URS because of TCC"
Description: "Ureterenoscopie because of a TCC"
* status = #done
* category = $SCT#387713003: "Surgical procedure (procedure)"
* code.text = "URS because of TCC"
* code.coding[0] = $SCT#38678700:2363702006=255109008 "Uretorenoscopy because of TCC"
* code.coding[1] = $SCT#38678700 "Uretorenoscopy"
* subject = Reference(DemoPatient)

Instance: URSboTCC3
InstanceOf: Procedure
Usage: #example
Title: "URS because of TCC"
Description: "Uretorenoscopy because of a TCC"
* status = #done
* category = $SCT#387713003 "Surgical procedure (procedure)"
* code.text = "URS because of TCC"
* code.coding[0] = $SCT#386787002 "ureterorenoscopie"
* subject = Reference(DemoPatient)
* reason.concept.text = "TCC"
* reason.concept.coding[0] = $SCT#255109008 "overgangscelcarcinoom van blaas"

Instance: URSboTCC4
InstanceOf: Procedure
Usage: #example
Title: "URS because of TCC"
Description: "Uretorenoscopy because of a TCC"
* status = #done
* category = $SCT#387713003 "Surgical procedure (procedure)"
* code.text = "URS because of TCC"
* code.coding[0] = $SCT#386787002 "ureterorenoscopie"
* subject = Reference(DemoPatient)
* reason.concept.text = "TCC"
* reason.concept.coding[0] = $SCT#255109008 "overgangscelcarcinoom van blaas"
* used.concept = $SCT#469891005 "flexible video ureterorenoscope"
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
* status = #completed
* code.text = "URS because of TCC"
* code.coding[0] = $SCT#386787002:363702006=255109008 "Ureterorenoscopy: Has focus = Transitional cell carcinoma"
* subject = Reference(DemoPatient)

Instance: URSboTCC2
InstanceOf: Procedure
Usage: #example
Title: "URS because of TCC"
Description: "Ureterenoscopie because of a TCC"
* status = #completed
* category = $SCT#387713003 "Surgical procedure"
* code.text = "URS because of TCC"
* code.coding[0] = $SCT#386787002:363702006=255109008 "Ureterorenoscopy: Has focus = Transitional cell carcinoma"
* code.coding[1] = $SCT#386787002 "Ureterorenoscopy"
* subject = Reference(DemoPatient)

Instance: URSboTCC3
InstanceOf: Procedure
Usage: #example
Title: "URS because of TCC"
Description: "Uretorenoscopy because of a TCC"
* status = #completed
* category = $SCT#387713003 "Surgical procedure"
* code.text = "URS because of TCC"
* code.coding[0] = $SCT#386787002 "Ureterorenoscopy"
* subject = Reference(DemoPatient)
* reason.concept.text = "TCC"
* reason.concept.coding[0] = $SCT#255109008 "Transitional cell carcinoma of bladder"

Instance: URSboTCC4
InstanceOf: Procedure
Usage: #example
Title: "URS because of TCC"
Description: "Uretorenoscopy because of a TCC"
* status = #completed
* category = $SCT#387713003 "Surgical procedure"
* code.text = "URS because of TCC"
* code.coding[0] = $SCT#386787002 "Ureterorenoscopy"
* subject = Reference(DemoPatient)
* reason.concept.text = "TCC"
* reason.concept.coding[0] = $SCT#255109008 "Transitional cell carcinoma of bladder"
* used.concept = $SCT#469891005 "flexible video ureterorenoscope"
# Tiro.health - FHIR IG

This Implementation Guide documents how Tiro.health exposes data through a FHIR API.
The IG is organised in two navigational structures:

1. By topic:

   Most projects are focussed on a specific disease area or specialty.
   Current availabel topics are

   - [Prostate Cancer](./1_ProstateCancer.html)
   - [Lung Cancer](./2_RespiratoryOncology.html)

2. By system:

   The Tiro.health platform has a clear seperation between content artifacts and patient-related data which makes that the system is devided in a **ReportServer** managing all the patient-related resources and a **ContentEngine** managing all the patiënt-agnostic resources.
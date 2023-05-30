Instance: ReportUpdates
InstanceOf: SubscriptionTopic
Usage: #definition
Title: "Report updates"
Description: "This topic triggers an event when a report is updated and the extraction of FHIR resources has completed."
* status = #active
* resourceTrigger
  * description = "Trigger when a report is created or updated and available as a FHIR Document."
  * resource = Canonical(Report)
  * supportedInteraction[0] = #create
  * supportedInteraction[1] = #update
* canFilterBy
  * description = "Filter by the report id"
  * filterParameter = "id"
  * comparator = #eq

Instance: SubcribeToIndividualReportUpdates
InstanceOf: Subscription
Usage: #example
Title: "Subcribe To Individual Report Updates"
Description: "This subscription triggers an event when a specific report is updated and the extraction of FHIR resources has completed."
* topic = Canonical(ReportUpdates)
* status = #requested
* reason = "Monitor the status of a specific report."
* filterBy
  * resourceType = Canonical(Report)
  * filterParameter = "id"
  * comparator = #eq
  * value = "example-report-id"
* channelType = #rest-hook
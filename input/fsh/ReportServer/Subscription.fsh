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

Instance: SubcribeToSingleReport
InstanceOf: Subscription
Usage: #example
Title: "Subcribe to Single Report"
Description: "This subscription triggers an event when a specific report is updated and the extraction of FHIR resources has completed."
* topic = Canonical(ReportUpdates)
* status = #requested
* reason = "Monitor the updates of transformed FHIR resources for a specific report."
* filterBy
  * resourceType = Canonical(Report)
  * filterParameter = "id"
  * comparator = #eq
  * value = "example-report-id"
* channelType = #rest-hook
* content = #full-resource

Instance: SubcribeToAllReports
InstanceOf: Subscription
Usage: #example
Title: "Subcribe to All Reports"
Description: "This subscription triggers an event when a report is updated and the extraction of FHIR resources has completed."
* topic = Canonical(ReportUpdates)
* status = #requested
* reason = "Monitor the updates of transformed FHIR resources for a all reports."
* channelType = #rest-hook
* content = #full-resource
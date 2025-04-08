CodeSystem: TaskType
Id: task-type
Title: "Task Type"
Description: "Supported task types by Tiro.health"
* #complete-questionnaire "Complete Questionnaire" "Request a practitioner to complete a questionnaire."
* #process-response "Process Response" "Process a response of a questionnaire."


CodeSystem: TaskInput
Id: task-input
Title: "Task Input Type"
Description: "Supported inputs for Tiro.health tasks."
* #questionnaire "Questionnaire" "A questionnaire to be completed by a practitioner."
* #initial-response "Initial Response" "An initial response to a questionnaire."
* #response-endpoint "Response Endpoint" "An endpoint to send the response to."

CodeSystem: TaskOutput
Id: task-output
Title: "Task Output Type"
Description: "Supported outputs for Tiro.health tasks."
* #questionnaire-response "Questionnaire Response" "A response to a questionnaire."
* #operation-outcome "Operation Outcome" "Additional information and diagnostics about the task."

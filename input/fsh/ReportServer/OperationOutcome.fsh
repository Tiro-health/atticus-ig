// OperationOutcome error contract for the Tiro.health FHIR API.
// Documentation: https://docs.tiro.health/fhir/errors

CodeSystem: OperationOutcomeIssueDetail
Id: operation-outcome-issue-detail
Title: "Operation Outcome Issue Detail"
Description: "Tiro.health detail codes carried in `OperationOutcome.issue.details.coding`. They give a stable, machine-readable classification of an issue beyond the standard FHIR issue-type (`OperationOutcome.issue.code`). Consumers should branch on these codes rather than on the free-text `issue.details.text`. Documentation: https://docs.tiro.health/fhir/errors"
* ^experimental = false
* ^caseSensitive = true
* ^contact.name = "Tiro.health Documentation"
* ^contact.telecom.system = #url
* ^contact.telecom.value = "https://docs.tiro.health/fhir/errors"
// Validation outcomes (currently emitted)
* #VALIDATE_PATIENT_SUCCESS "Patient validation successful" "Returned as an information/success issue when a Patient validation operation succeeds."
* #VALIDATE_TASK_SUCCESS "Task validation successful" "Returned as an information/success issue when a Task validation operation succeeds."
* #VALIDATE_TEMPLATE_FAILURE "Template validation failed" "The template failed validation; check for empty blocks or groups."
* #VALIDATE_RESOURCE_FAILURE "Resource validation failed" "The submitted resource failed validation; check for empty blocks or groups. Returned on 422 validation errors."
// Task/$initialize client errors (HTTP 400, issue.code = #invalid)
* #TEMPLATE_NOT_ACTIVE "Template not active or does not exist" "The referenced questionnaire template (canonical, optionally version-pinned) is not active — it was retired or superseded by a newer version, or does not exist. Returned as a 400 by Task/$initialize. Prefer a version-independent canonical."
* #TEMPLATE_EXPERIMENTAL_VERSION_REQUIRED "Experimental template requires an explicit version" "The referenced template is experimental and requires an explicit version in the canonical reference (e.g. `...|1.2.0`). Returned as a 400 by Task/$initialize."
* #INITIAL_RESPONSE_PATIENT_MISMATCH "Initial-response Patient mismatch" "The supplied initial-response QuestionnaireResponse references a different Patient than the Task. Returned as a 400 by Task/$initialize."
* #INITIAL_RESPONSE_CANONICAL_MISMATCH "Initial-response canonical mismatch" "The supplied initial-response QuestionnaireResponse is based on a different questionnaire canonical than the Task. Returned as a 400 by Task/$initialize."


ValueSet: OperationOutcomeIssueDetailVS
Id: operation-outcome-issue-detail
Title: "Operation Outcome Issue Detail"
Description: "All Tiro.health `OperationOutcome` issue-detail codes. Bound (example strength) to `OperationOutcome.issue.details` in the Tiro.health OperationOutcome profile."
* ^experimental = false
* include codes from system OperationOutcomeIssueDetail


Profile: TiroOperationOutcome
Parent: OperationOutcome
Id: tiro-operation-outcome
Title: "Tiro.health OperationOutcome"
Description: "The `OperationOutcome` returned by the Tiro.health FHIR API for error responses (and some validation outcomes). Every issue carries a human-readable `details.text` and a standard FHIR `issue.code`; some issues additionally carry a Tiro detail code in `issue.details.coding` (see the OperationOutcomeIssueDetail code system). Branch on `issue.code` and the coded `issue.details.coding`, never on `details.text`. Documentation: https://docs.tiro.health/fhir/errors"
* issue 1..* MS
* issue.severity MS
* issue.code MS
* issue.details 1..1 MS
* issue.details from OperationOutcomeIssueDetailVS (example)
* issue.details.text 1..1 MS

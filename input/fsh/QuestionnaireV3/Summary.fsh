Extension: QuestionnaireItemIncludInGroupSummary
Id: questionnaire-item-includInGroupSummary
Title: "Questionnaire Item Includ In Group Summary"
Description: "Indicates whether the question is included in the summary of the parent group."
Context: Questionnaire.item
* value[x] only boolean
* valueBoolean 1..1 MS
* valueBoolean ^comment = "If true, the question is included in the summary of the parent group; if false or absent, it is not included."
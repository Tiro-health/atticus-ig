// =============================================================================
// Template Lifecycle & Versioning
// =============================================================================
// Tiro.health manages Questionnaire templates through a structured lifecycle
// with semantic versioning. This file documents the publication states and
// version management approach.
//
// Lifecycle States:
//   draft    → Editable template, no version assigned
//   active   → Published, immutable, version "MAJOR.MINOR.PATCH"
//   retired  → Superseded by newer version, kept for reference
//
// State Transitions:
//   draft → active   (publish)   Assigns version, generates technical keys,
//                                converts to FHIR R5 Questionnaire
//   active → retired  (retire)   Marks as superseded
//   active → draft    (revise)   Creates new draft for next version
//   retired → active  (restore)  Only if no active version exists
//
// Semantic Versioning Rules:
//   PATCH bump (1.0.0 → 1.0.1): No structural changes (metadata only)
//   MINOR bump (1.0.0 → 1.1.0): Additive changes (new items added)
//   MAJOR bump (1.0.0 → 2.0.0): Breaking changes (items removed/restructured)
//
// Technical Keys:
//   Each questionnaire item receives a stable technicalKey on publish.
//   Technical keys are used for:
//   - SQL-on-FHIR ViewDefinition column mapping
//   - Stable references across template versions
//   - FHIRPath variable generation
//
// Canonical URL Pattern:
//   http://templates.tiro.health/templates/{identifier}|{version}
//   where {identifier} is a 32-character UUID hex string
// =============================================================================


CodeSystem: CSTemplateStatus
Id: template-status
Title: "Template Status"
Description: "Publication status codes for Tiro.health questionnaire templates."
* ^experimental = false
* ^caseSensitive = true
* ^content = #complete
* #draft "Draft" "Template is being authored and can be edited. No version is assigned."
* #active "Active" "Template is published and immutable. A semantic version is assigned."
* #retired "Retired" "Template is superseded by a newer version and no longer in active use."

ValueSet: VSTemplateStatus
Id: template-status
Title: "Template Status"
Description: "Publication statuses for questionnaire templates."
* ^experimental = false
* include codes from system CSTemplateStatus

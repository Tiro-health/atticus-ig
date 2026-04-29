# Data Provenance Tracking

## Overview

Atticus uses FHIR Provenance resources to track the origin and lifecycle of every field populated in a QuestionnaireResponse. This enables full auditability — whether a value was entered manually, extracted by AI, computed by a FHIRPath expression, or loaded from a preset.

Each populated field receives its own [`FormProvenance`](StructureDefinition-form-provenance.html) resource. These are returned as repeated `parameter[name="provenance"]` entries alongside the QuestionnaireResponse in the [`$populate`](OperationDefinition-tiro-populate.html) response.

## How Provenance Is Linked to a Field

Each Provenance targets the enclosing QuestionnaireResponse and identifies the specific populated item via the standard [`targetElement`](https://hl7.org/fhir/extensions/StructureDefinition-targetElement.html) extension:

```
Provenance.target[0].reference = "#"                        ← the QuestionnaireResponse
Provenance.target[0].extension[targetElement].valueUri      ← QuestionnaireResponse.item.id (a UUID)
```

Note: `targetElement` carries the item's **`id`** (a server-assigned UUID), not its `linkId`.

## Activity Codes

Every Provenance carries at least one [`FormActivity`](CodeSystem-form-activity.html) code in `activity.coding` plus an optional [ISO 21089 lifecycle](http://terminology.hl7.org/CodeSystem/iso-21089-lifecycle) code. For activities that have a specific child code, the backend also includes the parent code (e.g. `definition` + `data-import`).

### User Input

| Code | Description |
|------|-------------|
| `user` | Manually entered by the clinician |
| `manual` | Manual input without system assistance |

### Static Values

| Code | Description |
|------|-------------|
| `static` | Preconfigured value set without active user choice |
| `preset` | Loaded from a saved preset configuration |
| `initial-value` | Populated by `Questionnaire.item.initial` |

### Calculations

| Code | Description |
|------|-------------|
| `calculation` | Computed from a `calculatedExpression` (FHIRPath) |

### AI-Powered

| Code | Description |
|------|-------------|
| `ai` | Generic AI population |
| `ai-clipboard` | AI extraction from a clinical document (contextual-populate) |
| `speech-population` | Speech-to-text population |

### Data Import

| Code | Description |
|------|-------------|
| `data-import` | Import from FHIR resources or external data sources |
| `initial-expression` | Evaluated from `Questionnaire.item.initialExpression` — sent alongside `data-import` |
| `definition` | Matched via `Questionnaire.item.definition` to a FHIR resource — sent alongside `data-import` |

### ISO 21089 Lifecycle

| Code | Description |
|------|-------------|
| `originate` | Initial creation (used for all population activities) |
| `amend` | Modification of existing data |
| `merge` | Combining data from multiple sources |

## Agents

All automated Atticus engines use `provenance-participant-type#assembler` as the agent type and a `Device` resource as `agent.who`. Source document authors (for AI clipboard) use `provenance-participant-type#author`.

| Device | Display | Used for |
|--------|---------|----------|
| `Device/atticus-fhirpath-engine` | Atticus FHIRPath Engine | `initialExpression`, `calculatedExpression` |
| `Device/atticus-population-engine` | Atticus Population Engine | Initial values, repopulation, definition import |
| `Device/atticus-preset-engine` | Atticus Preset Engine | Preset loading |
| `Device/atticus-ai-marking-engine` | Atticus AI Marking Engine | HTML marking (labeling) |
| `Device/atticus-ai-population-engine` | Atticus AI Population Engine | AI clipboard extraction |

> **Note:** The backend uses integer Device IDs `Device/1`–`Device/5`; the IG uses descriptive IDs for readability.

The legacy [`AgentTypes`](CodeSystem-agent-types.html) CodeSystem (`fhirpath-engine`, `population-engine`, etc.) is retired. Existing persisted Provenance resources may still reference those codes.

## AI Reasoning — ProvenanceWhy and activity.text

For AI-populated fields, the model's reasoning can be recorded in two places:

- **`activity.text`**: Plain-string reasoning. This is what the backend currently populates.
- **`extension[why]`** ([`ProvenanceWhy`](StructureDefinition-provenance-why.html)): Markdown reasoning — a pre-adoption of the R6 `Provenance.why` element. This is the intended location going forward.

## AI Clipboard: Source Highlighting

When `contextual-populate` extracts a value from a clinical document, the Provenance includes an `entity` pointing to the source `DocumentReference`. The [`html-element-id`](StructureDefinition-html-element-id.html) extension on `entity.what` carries the IDs of the labeled HTML spans that contained the extracted text — enabling the UI to highlight the source passage:

```
Provenance.entity[0].role = "source"
Provenance.entity[0].what.reference = "DocumentReference/{id}"
Provenance.entity[0].what.extension[html-element-id][0].valueString = "label-001"
Provenance.entity[0].what.extension[html-element-id][1].valueString = "label-002"
```

## The $populate Response Shape

The [`$populate`](OperationDefinition-tiro-populate.html) response is a `Parameters` resource with one entry per populated field:

```
Parameters
├─ parameter[name="response"].resource     → QuestionnaireResponse
├─ parameter[name="issues"].resource       → OperationOutcome (optional)
└─ parameter[name="provenance"].resource   → FormProvenance  ← repeated, one per field
   └─ parameter[name="provenance"].resource → FormProvenance
   ...
```

### Contextual-Populate Flow

`contextual-populate` mode accepts clinical documents as context and drives the full AI pipeline:

1. Request supplies `context[name="clinical-artifacts"]` with one or more `DocumentReference` resources (HTML or PDF attachments).
2. The AI marking pipeline processes up to 5 documents in parallel: labels HTML spans, identifies which spans correspond to each questionnaire item, and extracts answer values.
3. Each extracted value gets a `FormProvenance` with:
   - `activity.coding` = `ai-clipboard` + `data-import`
   - `agent.who` = `Device/atticus-ai-population-engine`
   - `entity.what.reference` = the source `DocumentReference`
   - `entity.what.extension[html-element-id]` = span IDs for source highlighting
   - `activity.text` (and/or `extension[why]`) = the model's reasoning

## Examples

### User Input

{% fragment Provenance/prov-001 JSON %}

### AI Clipboard Population

{% fragment Provenance/prov-002 JSON %}

### FHIRPath Calculation

{% fragment Provenance/prov-003 JSON %}

### Definition-Based Import

{% fragment Provenance/prov-004 JSON %}

### Preset Population

{% fragment Provenance/prov-005 JSON %}

## Related Resources

- [FormProvenance profile](StructureDefinition-form-provenance.html)
- [FormActivity CodeSystem](CodeSystem-form-activity.html)
- [$populate OperationDefinition](OperationDefinition-tiro-populate.html)
- [ProvenanceWhy extension](StructureDefinition-provenance-why.html)
- [HtmlElementId extension](StructureDefinition-html-element-id.html)
- [ISO 21089 Lifecycle CodeSystem](http://terminology.hl7.org/CodeSystem/iso-21089-lifecycle)
- [FHIR Provenance Resource](http://hl7.org/fhir/provenance.html)

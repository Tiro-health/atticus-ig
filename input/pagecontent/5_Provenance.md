# Data Provenance Tracking

## Overview

Atticus uses FHIR Provenance resources to track the origin and lifecycle of data entered into forms. This enables full auditability and transparency about how each data field was populated, whether by manual user input, AI algorithms, calculations, or data imports.

## Architecture

### Core Concepts

1. **Provenance Resource**: A FHIR resource that records the origin and changes to data
2. **Target Element**: Links provenance to specific QuestionnaireResponse items using extensions
3. **Activity Codes**: Describe what type of operation was performed
4. **Agents**: Identify who or what performed the action

### Key Components

- **CodeSystem: FormActivity** (`http://fhir.tiro.health/CodeSystem/form-activity`) - Activities specific to form field population
- **CodeSystem: ISO 21089 Lifecycle** (`http://terminology.hl7.org/CodeSystem/iso-21089-lifecycle`) - Standard lifecycle events
- **Extension: targetElement** (`http://hl7.org/fhir/StructureDefinition/targetElement`) - Links provenance to specific response items

## Activity Types

### User Input Activities

| Code     | Display      | Description                                     |
| -------- | ------------ | ----------------------------------------------- |
| `user`   | User input   | Manually entered data by the user               |
| `manual` | Manual input | Manually entered data without system assistance |

### Static Value Activities

| Code            | Display       | Description                              |
| --------------- | ------------- | ---------------------------------------- |
| `static`        | Static value  | Preconfigured value picked by a user     |
| `preset`        | Preset        | Populated by a preset configuration      |
| `initial-value` | Initial value | Populated by an initial value definition |

### Calculation Activities

| Code          | Display              | Description                                             |
| ------------- | -------------------- | ------------------------------------------------------- |
| `calculation` | Calculation          | A calculation has been performed based on an expression |
| `fhirpath`    | FHIRPath calculation | A calculation performed using FHIRPath expression       |

### AI-Powered Activities

| Code                | Display                 | Description                                  |
| ------------------- | ----------------------- | -------------------------------------------- |
| `ai`                | AI population           | An AI algorithm has generated field values   |
| `speech-population` | Speech-based population | Speech-to-text solution generated the values |
| `ai-clipboard`      | AI Clipboard            | AI engine processed clipboard content        |

### Data Import Activities

| Code          | Display     | Description                                              |
| ------------- | ----------- | -------------------------------------------------------- |
| `data-import` | Data Import | Values imported from other resources or external servers |

### Lifecycle Activities

| Code     | Display | Description                                      |
| -------- | ------- | ------------------------------------------------ |
| `submit` | Submit  | Form submitted for review or final processing    |
| `amend`  | Amend   | Form amended or updated after initial submission |

## ISO 21089 Lifecycle Events

Atticus uses standard ISO 21089 lifecycle events in combination with form-specific activities:

- **originate**: Initial creation of data (most form population activities)
- **amend**: Modification of existing data
- **merge**: Combining data from multiple sources

## Implementation

### Creating Provenance Records

When a form field is populated, a Provenance resource is created with:

1. **Target**: Reference to the QuestionnaireResponse with `targetElement` extension pointing to the specific item.id
2. **Activity**: Coding array combining form-specific activity and ISO 21089 lifecycle event
3. **Recorded**: Timestamp when the activity occurred
4. **Agent**: Who or what performed the action

### Example: User Input

{% fragment Provenance/prov-001 JSON %}

### Example: AI Clipboard Population

{% fragment Provenance/prov-002 JSON %}

### Example: FHIRPath Calculation

{% fragment Provenance/prov-003 JSON %}

## Agent Types

Agents represent actors that perform or participate in actions:

| Type                | Display           | Description                                    |
| ------------------- | ----------------- | ---------------------------------------------- |
| `fhirpath-engine`   | FHIRPath Engine   | FHIRPath expression evaluation engine          |
| `population-engine` | Population Engine | Engine that populates forms from external data |
| `preset-engine`     | Preset Engine     | Engine that applies preset configurations      |

### Agent Structure

Agents can include:

- **type**: Classification of the agent (using `agent-types` CodeSystem)
- **role**: Specific roles the agent played in the activity
- **who**: Reference or display name identifying the agent
- **onBehalfOf**: Reference to who the agent was acting on behalf of (e.g., AI acting on behalf of a practitioner)

## Best Practices

1. **Always Record Provenance**: Every data modification should have associated provenance
2. **Use Hierarchical Codes**: Combine specific codes with parent codes (e.g., `ai-clipboard` with `ai`)
3. **Include Timestamps**: Always populate the `recorded` field
4. **Link to Specific Items**: Use `targetElement` extension to point to exact QuestionnaireResponse.item.id
5. **Preserve Agents**: Include both automated agents and the user they're acting on behalf of
6. **Track Amendments**: Use `amend` activity and ISO 21089 lifecycle when updating existing data

## Use Cases

### Audit Trail

Track who entered what data and when, providing complete transparency for regulatory compliance.

### Data Quality Assessment

Identify fields populated by AI vs. manual entry to assess confidence levels.

### Workflow Optimization

Analyze which fields are frequently manually corrected after AI population to improve algorithms.

### Regulatory Compliance

Demonstrate compliance with requirements for tracking data provenance in clinical systems.

### Data Lineage

Trace data back to its source through the `entity` array with role "source" or "derivation".

## Related Resources

- [ISO 21089 Lifecycle CodeSystem](http://terminology.hl7.org/CodeSystem/iso-21089-lifecycle)
- [FHIR Provenance Resource](http://hl7.org/fhir/provenance.html)
- [QuestionnaireResponse](http://hl7.org/fhir/questionnaireresponse.html)
- [FormActivity CodeSystem](CodeSystem-form-activity.html)
- [AgentTypes CodeSystem](CodeSystem-agent-types.html)

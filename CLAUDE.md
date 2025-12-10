# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## Repository Overview

This is a FHIR R5 Implementation Guide (IG) for Tiro.health's Atticus reporting system and Cicero content library. The IG is built using SUSHI (FHIR Shorthand) and the HL7 IG Publisher.

**Canonical URL:** `http://fhir.tiro.health`
**FHIR Version:** 5.0.0
**Dependencies:** HL7 FHIR SDC (Structured Data Capture) 4.0.0-ballot

## Build Commands

### Initial Setup
```bash
# Update/download the IG Publisher
./_updatePublisher.sh

# Or on Windows
./_updatePublisher.bat
```

### Building the IG
```bash
# Generate the IG once
./_genonce.sh

# Or on Windows
./_genonce.bat
```

```bash
# Generate continuously (watches for changes)
./_gencontinuous.sh

# Or on Windows
./_gencontinuous.bat
```

The build process:
1. SUSHI compiles FSH files from `input/fsh/` into `fsh-generated/resources/`
2. IG Publisher generates the full Implementation Guide into `output/`
3. The build uses the custom template in `ig-tiro-template/`

## Architecture

### FSH File Organization

The `input/fsh/` directory is organized by functional domain:

- **`QuestionnaireV3/`** - Core Questionnaire profiles and extensions
  - `Base.fsh` - TiroQuestionnaire profile, core extensions (RenderType, Orientation, Regex, AnswerComment), RuleSets for common patterns, and Library instances for renderers
  - `Layout.fsh` - Layout and orientation examples
  - `Summary.fsh` - Group summary extensions
  - `Provenance.fsh` - Form activity tracking with CodeSystems for activities and agent types
  - `NarrativeGeneration.fsh` - Template-based narrative generation
  - `Task.fsh` - Task-related questionnaire features
  - `Library.fsh` - Library management for renderers
  - `SVG.fsh` - SVG integration
  - `KWSBookmarks.fsh` - Bookmark functionality

- **`ReportServer/`** - Backend report processing
  - `Population.fsh` - Report Bundle profile and population request parameters
  - `Subscription.fsh` - SubscriptionTopic and Subscription instances for report updates
  - `Graphs.fsh` - Graph visualizations
  - `NamingSystem.fsh` - Identifier systems

- **`ContentEngine/`** - Reusable content blocks
  - `Block.fsh` - Modular questionnaire blocks with sub-questionnaire references

- **`Terminology/`** - CodeSystems and ValueSets
  - `CodeSystem.fsh` - Custom code systems
  - `ValueSetExpansion.fsh` - ValueSet definitions

- **`OMOP/`** - OMOP Common Data Model integration
  - `5.4.fsh` - OMOP CDM 5.4 mappings

- **`Examples/`** - Concrete examples of questionnaires and reports
  - Clinical use cases: `PCaStagingReport.fsh`, `LCaStagingReport.fsh`, `REO.fsh`
  - Input patterns: `MultipleChoice.fsh`, `Scale.fsh`, `LabMeasurement.fsh`, `QualityIndicator.fsh`

### Key Architectural Concepts

**Questionnaire Rendering System:**
- Uses `RenderType` extension with canonical references to Library resources
- Two main renderers: `TreeLayoutRenderer` (v3 tree layout) and `TableLayoutRenderer` (v2 table layout)
- RuleSets in `Base.fsh` provide reusable patterns: `QuestionnaireV3`, `AnswerContainer`, `QuestionGroup`, `CodingDropdown`, `Textbox`, `Calculator`, etc.

**Modular Report Structure:**
- Reports use Bundle resources with type #document (see `Report` profile in `Population.fsh`)
- Questionnaires can reference sub-questionnaires using `BlockReference` RuleSet
- Allows composition of reports from reusable blocks

**Provenance Tracking:**
- `FormActivity` CodeSystem defines how data enters forms (user input, AI, calculations, presets, etc.)
- `AgentTypes` CodeSystem identifies automated systems (FHIRPath engine, population engine, etc.)
- Provenance resources link to specific QuestionnaireResponse items via `targetElement` extension

**Narrative Generation:**
- Template-based system using Liquid or Jinja2 templates
- `NarrativeTemplate` extension on Questionnaire items
- `NarrativeTemplateSnippet` for reusable template fragments

## FSH Development Patterns

### Using RuleSets
Common patterns are defined as RuleSets in `Base.fsh`:
```fsh
* insert QuestionnaireV3          // Set render type to TreeLayoutRenderer
* insert AnswerContainer          // Create answer container group
* insert QuestionGroup            // Create question group
* insert CodingDropdown           // Dropdown for coding selection
* insert Textbox                  // String textbox
* insert DecimalTextbox(unit)     // Decimal with unit
* insert Calculator               // Calculator reference lookup
```

### Referencing Sub-Questionnaires
```fsh
* insert BlockReference(linkId, canonical-url|version)
```

### Item Controls
Use Tiro custom item controls from `TiroItemControl` CodeSystem:
- `question-group` - Hierarchical tree layout structure
- `drop-down` - Single selection dropdown
- `chips` - Multi-select chips
- `text-box` / `text-area` - Text input
- `date-field` - Date picker
- `calculator` - Calculation widget
- `summarized-group` - Group with summary of child items

## Configuration Files

- `sushi-config.yaml` - SUSHI configuration (IG metadata, dependencies, menus)
- `ig.ini` - IG Publisher configuration pointing to generated IG JSON and custom template
- `.nvmrc` - Node.js version for SUSHI (if needed)

## Output and Generated Files

- `fsh-generated/` - SUSHI output (FHIR JSON resources compiled from FSH)
- `output/` - Final IG website (HTML, JSON, XML)
- `temp/` - Temporary build artifacts
- `input-cache/` - Downloaded IG Publisher JAR

## Important Notes

- The IG uses FHIR R5, not R4 or R4B
- Manual slice ordering is enabled (`manualSliceOrdering: true`)
- Always set meta.profile automatically (`setMetaProfile: always`)
- When modifying FSH files, the build will fail if there are syntax errors - check SUSHI output carefully
- Custom item controls require both HL7 standard codes and Tiro custom codes in the itemControl extension

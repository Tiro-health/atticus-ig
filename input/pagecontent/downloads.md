# Downloads

This page provides downloadable artifacts for the Tiro.health Implementation Guide.

### Definitions

The following definitions of the artifacts defined as part of this Implementation Guide are available for download. Note that these definitions do not include the narrative content that is found on each of the pages — they are the raw computable artifacts only.

- [JSON](definitions.json.zip)
- [XML](definitions.xml.zip)
- [TTL](definitions.ttl.zip)

### Examples

A package containing all the examples used in this Implementation Guide is available:

- [JSON](examples.json.zip)
- [XML](examples.xml.zip)
- [TTL](examples.ttl.zip)

### NPM Package

This Implementation Guide is also published as an NPM package for use with FHIR tooling such as the IG Publisher, SUSHI, and the FHIR Validator:

- [Package](package.tgz)

To install via SUSHI, add the following to the `dependencies` section of your `sushi-config.yaml`:

```yaml
dependencies:
  tiro-health.fhir: 0.1.0
```

### Validator Pack

The FHIR Validator Pack contains all the StructureDefinitions, ValueSets, CodeSystems, and other conformance resources needed to validate against this Implementation Guide:

- [Validator Pack](validator.pack)

To validate a resource using the [HL7 FHIR Validator](https://confluence.hl7.org/display/FHIR/Using+the+FHIR+Validator):

```
java -jar validator_cli.jar -ig tiro-health.fhir#0.1.0 my-resource.json
```

### Schemas

- [XML Schemas](fhir.schema.json.zip)
- [JSON Schema](fhir.schema.json.zip)

### Source

The source FHIR Shorthand (FSH) files and full source of this Implementation Guide are available on GitHub:

- [Source Repository](https://github.com/tiro-health/atticus-ig)

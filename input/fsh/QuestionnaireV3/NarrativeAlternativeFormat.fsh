Extension: NarrativeAlternativeFormat
Id: narrative-alternative-format
Title: "Narrative Alternative Format"
Description: "Provides the narrative content in an alternative format such as RTF or plain text."
Context: Narrative
* value[x] only Attachment
* valueAttachment 1..1
* valueAttachment.contentType 1..1
* valueAttachment.contentType from NarrativeAlternativeFormatMimeTypes (required)
* valueAttachment.data 1..1

ValueSet: NarrativeAlternativeFormatMimeTypes
Id: narrative-alternative-format-mime-types
Title: "Narrative Alternative Format MIME Types"
Description: "MIME types supported for narrative alternative formats"
* urn:ietf:bcp:13#text/rtf "RTF"
* urn:ietf:bcp:13#text/plain "Plain Text"

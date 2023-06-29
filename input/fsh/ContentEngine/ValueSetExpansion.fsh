Extension: MatchScore
Id: valueset-expansion-match-score
Title: "ValueSet Expansion Match Score"
Description: "This extension adds a score to each code in the expansion of a value set. The score is used to sort the codes in the expansion."
//Context: ValueSet --> Next release of SUSHI will support this
* value[x] only decimal
* value[x] 1..1

Instance: ValueSetWithExpansionScore
InstanceOf: ValueSet 
Usage: #example
Title: "Value Set With Expansion Score"
Description: "This value set has an expansion with scores for each code."
* status = #active
* expansion
  * timestamp = 2019-01-01T00:00:00Z
  * contains
    * code = #a
    * display = "A"
    * extension[MatchScore].valueDecimal = 0.5
    
Extension: PreExpandFlag
Id: valueset-pre-expand-flag
Title: "Pre Expand Flag"
Description: "Flag to indicate that the value set has been pre-expanded."
//Context: ValueSet --> Next release of SUSHI will support this
* value[x] only boolean
* value[x] 1..1

Instance: ValueSetWithPreExpandFlag
InstanceOf: ValueSet
Usage: #example
Title: "Value Set With Pre Expand Flag"
Description: "This value set has a flag to indicate that it has been pre-expanded."
* status = #active
* extension[PreExpandFlag].valueBoolean = true


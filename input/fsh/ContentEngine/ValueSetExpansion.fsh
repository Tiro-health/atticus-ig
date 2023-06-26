Extension: MatchScore
Id: value-set-expansion-match-score
Title: "Value Set Expansion Match Score"
Description: "This extension adds a score to each code in the expansion of a value set. The score is used to sort the codes in the expansion."
Context: ValueSet
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
    

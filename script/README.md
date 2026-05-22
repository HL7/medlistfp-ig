Use Case Spreadsheet

* Convert Actor (columns B) -> ActorDefinition
    .status = #draft
    .type = 'C' contains 'System'?#system:#person
    .name = PascalCase(B)
    .title = B
* Convert Use Case to ExampleScenario and reference the actors
    .actor.type = 'B' contains 'System'?#system:#person
    .actor.key = row#
    .actor.title = B
    E contains steps; for each line create process.title

ExampleScenario for Use Case with processes for each Event step and then sub-proces for each row in E

Starts at row 7.
-------------
See Gemini chat history for prompts... TODO: document the mapping result...
**N.B. requestReference needed for rendering to be correct otherwise the steps are appended in 1 line!**
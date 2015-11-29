Feature: Comparing different field types

  As a developer testing a relational database
  I want to verify my database content and associations the same way
  So that database verifications are intuitive.

  Rules:
  - content in data columns without a Cucumberator is compared as-is with the table content
  - content in data columns can be modified through a Cucumberator before verification
  - associated records can be converted to text via a Cucumberator


  Background:
    Given the episodes:
      | SHOW          | NAME                  | YEAR |
      | Star Trek TNG | Encounter at Farpoint | 1987 |
      | Star Trek TNG | All Good Things       | 1994 |


  Scenario: verifying string fields
    When running "ActiveCucumber.diff_all! Episode, table" with this table:
      | NAME                  |
      | Encounter at Farpoint |
      | All Good Things       |
    Then the test passes


  Scenario: verifying non-string fields
    When running "ActiveCucumber.diff_all! Episode, table" with this table:
      | YEAR |
      | 1987 |
      | 1994 |
    Then the test passes


  Scenario: verifying associated fields through a Cucumberator
    When running "ActiveCucumber.diff_all! Episode, table" with this table:
      | SHOW          | NAME                  |
      | Star Trek TNG | Encounter at Farpoint |
      | Star Trek TNG | All Good Things       |
    Then the test passes

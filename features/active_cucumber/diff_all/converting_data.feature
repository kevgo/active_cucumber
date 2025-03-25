Feature: Comparing different field types

  As a developer testing a relational database
  I want to verify my database content and associations the same way
  So that database verifications are intuitive.

  Rules:
  - the user can define a Cucumberator to define custom Cucumber representations of fields or associated records
  - if the Cucumberator doesn't define a conversion or is missing altogether, the content is compared as-is


  Background:
    Given the episodes:
      | SHOW          | NAME                  | YEAR |
      | Star Trek TNG | Encounter at Farpoint | 1987 |
      | Star Trek TNG | All Good Things       | 1994 |


  Scenario: verifying a record without a Cucumberator
    Given the genres:
      | NAME            |
      | Science Fiction |
    When running "ActiveCucumber.diff_all!(Genre, table)" with this table:
      | NAME            |
      | Science Fiction |
    Then the test passes


  Scenario: verifying fields not defined in the Cucumberator
    When running "ActiveCucumber.diff_all!(Episode, table)" with this table:
      | NAME                  |
      | Encounter at Farpoint |
      | All Good Things       |
    Then the test passes


  Scenario: verifying numeric fields
    When running "ActiveCucumber.diff_all!(Episode, table)" with this table:
      | YEAR |
      | 1987 |
      | 1994 |
    Then the test passes


  Scenario: verifying associated fields through a Cucumberator
    When running "ActiveCucumber.diff_all!(Episode, table)" with this table:
      | SHOW          | NAME                  |
      | Star Trek TNG | Encounter at Farpoint |
      | Star Trek TNG | All Good Things       |
    Then the test passes

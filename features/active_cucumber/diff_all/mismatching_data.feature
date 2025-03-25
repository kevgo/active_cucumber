Feature: comparing against all existing records

  As a developer verifying my database content
  I want that my specs verify the exact database content
  So that I can be sure that my application behaves exactly as I think it does.

  Rules:
  - missing rows cause test failure
  - extra rows cause test failure
  - mismatching fields cause test failure


  Background:
    Given the episodes:
      | SHOW          | NAME                  | YEAR |
      | Star Trek TNG | Encounter at Farpoint | 1987 |
      | Star Trek TNG | All Good Things       | 1994 |


  Scenario: complete table match
    When running "ActiveCucumber.diff_all!(Episode, table)" with this table:
      | SHOW          | NAME                  | YEAR |
      | Star Trek TNG | Encounter at Farpoint | 1987 |
      | Star Trek TNG | All Good Things       | 1994 |
    Then the test passes


  Scenario: missing a record
    When running "ActiveCucumber.diff_all!(Episode, table)" with this table:
      | SHOW          | NAME                  |
      | Star Trek TNG | Encounter at Farpoint |
    Then the test fails
    And Cucumparer prints the error message "Tables were not identical"


  Scenario: an extra record
    When running "ActiveCucumber.diff_all!(Episode, table)" with this table:
      | SHOW          | NAME                  |
      | Star Trek TNG | Encounter at Farpoint |
      | Star Trek TNG | All Good Things       |
      | Star Trek TNG | The Nth Degree        |
    Then the test fails
    And Cucumparer prints the error message "Tables were not identical"


  Scenario: mismatching data in a table cell
    When running "ActiveCucumber.diff_all!(Episode, table)" with this table:
      | SHOW          | NAME                  |
      | Star Trek TOS | Encounter at Farpoint |
      | Star Trek TNG | All Good Things       |
    Then the test fails
    And Cucumparer prints the error message "Tables were not identical"

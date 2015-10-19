Feature: Cucumparer.diff_all!

  As a Cucumber user
  I want to verify all existing records using a Cucumber table
  So that I can easily and intuitively check the result of my database-facing operations.


  Background:
    Given the TV episodes:
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


  Scenario: complete table match
    When running "ActiveCucumber.diff_all! Episode, table" with this table:
      | SHOW          | NAME                  | YEAR |
      | Star Trek TNG | Encounter at Farpoint | 1987 |
      | Star Trek TNG | All Good Things       | 1994 |
    Then the test passes


  Scenario: missing a record
    When running "ActiveCucumber.diff_all! Episode, table" with this table:
      | SHOW          | NAME                  |
      | Star Trek TNG | Encounter at Farpoint |
    Then the test fails
    And Cucumparer prints the error message "Tables were not identical"


  Scenario: an extra record
    When running "ActiveCucumber.diff_all! Episode, table" with this table:
      | SHOW          | NAME                  |
      | Star Trek TNG | Encounter at Farpoint |
      | Star Trek TNG | All Good Things       |
      | Star Trek TNG | The Nth Degree        |
    Then the test fails
    And Cucumparer prints the error message "Tables were not identical"


  Scenario: mismatching data in a table cell
    When running "ActiveCucumber.diff_all! Episode, table" with this table:
      | SHOW          | NAME                  |
      | Star Trek TOS | Encounter at Farpoint |
      | Star Trek TNG | All Good Things       |
    Then the test fails
    And Cucumparer prints the error message "Tables were not identical"

Feature: Verifying only certain columns

  Background:
    Given the episodes:
      | SHOW          | NAME                  | YEAR |
      | Star Trek TNG | Encounter at Farpoint | 1987 |
      | Star Trek TNG | All Good Things       | 1994 |


  Scenario: verifying all columns
    When running "ActiveCucumber.diff_all!(Episode, table)" with this table:
      | SHOW          | NAME                  | YEAR |
      | Star Trek TNG | Encounter at Farpoint | 1987 |
      | Star Trek TNG | All Good Things       | 1994 |
    Then the test passes


  Scenario: verifying a subset of columns
    When running "ActiveCucumber.diff_all!(Episode, table)" with this table:
      | YEAR |
      | 1987 |
      | 1994 |
    Then the test passes

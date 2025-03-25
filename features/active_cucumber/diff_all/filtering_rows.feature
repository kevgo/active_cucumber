Feature: Verifying only certain database rows

  Background:
    Given the episodes:
      | SHOW          | NAME                  | YEAR |
      | Star Trek TOS | The Paradise Syndrome | 1968 |
      | Star Trek TNG | Encounter at Farpoint | 1987 |
      | Star Trek TNG | All Good Things       | 1994 |


  Scenario: comparing against the whole table by providing an ActiveRecord class
    When running "ActiveCucumber.diff_all!(Episode, table)" with this table:
      | SHOW          | NAME                  | YEAR |
      | Star Trek TOS | The Paradise Syndrome | 1968 |
      | Star Trek TNG | Encounter at Farpoint | 1987 |
      | Star Trek TNG | All Good Things       | 1994 |
    Then the test passes


  Scenario: comparing against a subset of a table by providing an AREL query
    When running "ActiveCucumber.diff_all!(Show.first.episodes, table)" with this table:
      | SHOW          | NAME                  | YEAR |
      | Star Trek TOS | The Paradise Syndrome | 1968 |
    Then the test passes

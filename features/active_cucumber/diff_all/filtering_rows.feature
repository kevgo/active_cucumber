Feature: Verifying only certain database rows

  As a developer specifying the result of database operations
  I want to have the choice to verify either the full database content or only a part of it
  So that my specs aren't polluted by independent side effects and remain focussed on the functionality described.

  Rules:
  - when providing an ActiveRecord class to `ActiveCucumber.diff_all!`
    it verifies the whole database table
  - when providing an AREL query to `ActiveCucumber.diff_all!`
    it verifies only the specified records in the respective table


  Background:
    Given the episodes:
      | SHOW          | NAME                  | YEAR |
      | Star Trek TOS | The Paradise Syndrome | 1968 |
      | Star Trek TNG | Encounter at Farpoint | 1987 |
      | Star Trek TNG | All Good Things       | 1994 |


  Scenario: comparing against the whole table by providing an ActiveRecord class
    When running "ActiveCucumber.diff_all! Episode, table" with this table:
      | SHOW          | NAME                  | YEAR |
      | Star Trek TOS | The Paradise Syndrome | 1968 |
      | Star Trek TNG | Encounter at Farpoint | 1987 |
      | Star Trek TNG | All Good Things       | 1994 |
    Then the test passes


  Scenario: comparing against a subset of a table by providing an AREL query
    When running "ActiveCucumber.diff_all! Show.first.episodes, table" with this table:
      | SHOW          | NAME                  | YEAR |
      | Star Trek TOS | The Paradise Syndrome | 1968 |
    Then the test passes

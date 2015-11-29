Feature: Verifying only certain columns

  As a developer working only on a subset of database columns
  I want to specify only those columns in my tests
  So that my specs are concise, noise free, and to the point.

  Rules:
  - tables given to `diff_all!` can contain only a subset of the existing columns
  - only the given columns are verified against the database content


  Background:
    Given the episodes:
      | SHOW          | NAME                  | YEAR |
      | Star Trek TNG | Encounter at Farpoint | 1987 |
      | Star Trek TNG | All Good Things       | 1994 |


  Scenario: verifying all columns
    When running "ActiveCucumber.diff_all! Episode, table" with this table:
      | SHOW          | NAME                  | YEAR |
      | Star Trek TNG | Encounter at Farpoint | 1987 |
      | Star Trek TNG | All Good Things       | 1994 |
    Then the test passes


  Scenario: verifying a subset of columns
    When running "ActiveCucumber.diff_all! Episode, table" with this table:
      | YEAR |
      | 1987 |
      | 1994 |
    Then the test passes

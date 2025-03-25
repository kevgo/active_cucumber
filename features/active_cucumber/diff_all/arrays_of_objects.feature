Feature: Comparing arrays of ActiveRecord instances

  Background:
    Given the episodes:
      | NAME                  | YEAR |
      | Encounter at Farpoint | 1987 |
      | All Good Things       | 1994 |


  Scenario: comparing all instances of an ActiveRecord class
    When running "ActiveCucumber.diff_all!(Episode, table)" with this table:
      | NAME                  | YEAR |
      | Encounter at Farpoint | 1987 |
      | All Good Things       | 1994 |
    Then the test passes


  Scenario: comparing an array of ActiveRecord instances
    When running "ActiveCucumber.diff_all!([Episode.first, Episode.last], table)" with this table:
      | NAME                  | YEAR |
      | Encounter at Farpoint | 1987 |
      | All Good Things       | 1994 |
    Then the test passes

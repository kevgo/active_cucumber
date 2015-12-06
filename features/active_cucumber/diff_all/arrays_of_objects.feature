Feature: Comparing arrays of ActiveRecord instances

  As a developer having complex database query logic
  I want to be able to compare against a manually created array of ActiveRecord objects
  So that I can use ActiveCucumber for a large variety of data sources.

  Rules:
  - one can give an ActiveRecord class or an array of ActiveRecord instances to ActiveCucumber
  - ActiveCucumber choses the Cucumperer based on the class of each record


  Background:
    Given the episodes:
      | NAME                  | YEAR |
      | Encounter at Farpoint | 1987 |
      | All Good Things       | 1994 |


  Scenario: comparing all instances of an ActiveRecord class
    When running "ActiveCucumber.diff_all! Episode, table" with this table:
      | NAME                  | YEAR |
      | Encounter at Farpoint | 1987 |
      | All Good Things       | 1994 |
    Then the test passes


  Scenario: comparing an array of ActiveRecord instances
    When running "ActiveCucumber.diff_all! [Episode.first, Episode.last], table" with this table:
      | NAME                  | YEAR |
      | Encounter at Farpoint | 1987 |
      | All Good Things       | 1994 |
    Then the test passes

Feature: Cucumparer.diff_one!

  As a Cucumber user
  I want to verify a single record using a detailed Cucumber table
  So that I can easily and intuitively check individual database entries.


  Background:
    Given the TV episode:
      | SHOW | Star Trek TNG   |
      | NAME | All Good Things |
      | YEAR | 1994            |


  Scenario: verifying string fields
    When running "ActiveCucumber::Cucumparer.diff_one! @episode, table" with this table:
      | NAME | All Good Things |
    Then the test passes


  Scenario: verifying non-string fields
    When running "ActiveCucumber::Cucumparer.diff_one! @episode, table" with this table:
      | YEAR | 1994            |
    Then the test passes


  Scenario: verifying associated fields
    When running "ActiveCucumber::Cucumparer.diff_one! @episode, table" with this table:
      | SHOW | Star Trek TNG   |
      | NAME | All Good Things |
    Then the test passes


  Scenario: complete table match
    When running "ActiveCucumber::Cucumparer.diff_one! @episode, table" with this table:
      | SHOW | Star Trek TNG   |
      | NAME | All Good Things |
      | YEAR | 1994            |
    Then the test passes


  Scenario: providing a non-existing field
    When running "ActiveCucumber::Cucumparer.diff_one! @episode, table" with this table:
      | NAME   | All Good Things |
      | FOOBAR | 1994            |
    Then the test fails
    And Cucumparer prints the error message "undefined method.*foobar"


  Scenario: mismatching data in a table cell
    When running "ActiveCucumber::Cucumparer.diff_one! @episode, table" with this table:
      | SHOW | Star Trek TOS   |
      | NAME | All Good Things |
    Then the test fails
    And Cucumparer prints the error message "Tables were not identical"



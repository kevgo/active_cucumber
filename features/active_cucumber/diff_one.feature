Feature: ActiveCucumber.diff_one!

  Background:
    Given the episode:
      | SHOW | Star Trek TNG   |
      | NAME | All Good Things |
      | YEAR | 1994            |


  Scenario: verifying string fields
    When running "ActiveCucumber.diff_one!(@created_episode, table)" with this table:
      | NAME | All Good Things |
    Then the test passes


  Scenario: verifying non-string fields
    When running "ActiveCucumber.diff_one!(@created_episode, table)" with this table:
      | YEAR | 1994 |
    Then the test passes


  Scenario: verifying associated fields
    When running "ActiveCucumber.diff_one!(@created_episode, table)" with this table:
      | SHOW | Star Trek TNG   |
      | NAME | All Good Things |
    Then the test passes


  Scenario: complete table match
    When running "ActiveCucumber.diff_one!(@created_episode, table)" with this table:
      | SHOW | Star Trek TNG   |
      | NAME | All Good Things |
      | YEAR | 1994            |
    Then the test passes


  Scenario: providing a non-existing field
    When running "ActiveCucumber.diff_one!(@created_episode, table)" with this table:
      | NAME   | All Good Things |
      | FOOBAR | 1994            |
    Then the test fails
    And Cucumparer prints the error message "undefined method.*foobar"


  Scenario: mismatching data in a table cell
    When running "ActiveCucumber.diff_one!(@created_episode, table)" with this table:
      | SHOW | Star Trek TOS   |
      | NAME | All Good Things |
    Then the test fails
    And Cucumparer prints the error message "Tables were not identical"


  Scenario: using context values
    Given the subscription:
      | SUBSCRIBER | Q             |
      | SHOW       | Star Trek TNG |
    When running "ActiveCucumber.diff_one!(@created_subscription, table, context: { current_user: 'Q' })" with this table:
      | SUBSCRIBER | me            |
      | SHOW       | Star Trek TNG |
    Then the test passes

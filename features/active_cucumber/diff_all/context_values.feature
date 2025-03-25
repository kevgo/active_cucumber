Feature: Using contextual data

  Scenario: using contextual data
    Given the subscriptions:
      | SUBSCRIBER | SHOW          |
      | Q          | Star Trek TNG |
    When running "ActiveCucumber.diff_all!(Subscription, table, context: { current_user: 'Q' })" with this table:
      | SUBSCRIBER | SHOW          |
      | me         | Star Trek TNG |
    Then the test passes

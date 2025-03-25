Feature: Using contextual data

  As a developer wanting to use non-database data in my database specs
  I want to be able to provide contextual data to ActiveCucumber
  So that I can use it in my specs.

  Rules:
  - contextual data is provided as an additional parameter containing key-value pairs in calls to ActiveCucumber
  - all contextual data is made available to Cucumberators as instance variables whose name is the key and value is the value


  Scenario: using contextual data
    Given the subscriptions:
      | SUBSCRIBER | SHOW          |
      | Q          | Star Trek TNG |
    When running "ActiveCucumber.diff_all!(Subscription, table, context: { current_user: 'Q' })" with this table:
      | SUBSCRIBER | SHOW          |
      | me         | Star Trek TNG |
    Then the test passes

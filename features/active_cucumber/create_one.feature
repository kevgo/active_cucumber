Feature: ActiveCucumber.create_one

  (see ./create_many.feature)


  Scenario: creating string columns
    When running "ActiveCucumber.create_one Episode, table" with this table:
      | NAME                  | Encounter at Farpoint |
    Then the database contains the given episode


  Scenario: creating integer columns
    When running "ActiveCucumber.create_one Episode, table" with this table:
      | YEAR                  | 1994 |
    Then the database contains the given episode


  Scenario: creating associated objects
    When running "ActiveCucumber.create_one Episode, table" with this table:
      | SHOW          | Star Trek TNG         |
      | NAME          | Encounter at Farpoint |
    Then the database contains the given episode
    And the database contains the show "Star Trek TNG"


  Scenario: using context values
    When running "ActiveCucumber.create_one Subscription, table, context: { current_user: 'Q' }" with this table:
      | SUBSCRIBER | me            |
      | SHOW       | Star Trek TNG |
    Then the database contains the subscriptions:
      | SUBSCRIBER | SHOW          |
      | Q          | Star Trek TNG |


  Scenario: complex example
    When running "ActiveCucumber.create_one Episode, table" with this table:
      | SHOW | Star Trek TNG         |
      | NAME | Encounter at Farpoint |
      | YEAR | 1987                  |
    Then the database contains the given episode
    And the database contains the show "Star Trek TNG"


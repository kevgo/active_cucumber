Feature: ActiveCucumber.create_many

  Scenario: creating string columns
    When running "ActiveCucumber.create_many(Episode, table)" with this table:
      | NAME                  |
      | Encounter at Farpoint |
      | All Good Things       |
    Then the database contains the given episodes


  Scenario: creating integer columns
    When running "ActiveCucumber.create_many(Episode, table)" with this table:
      | YEAR |
      | 1987 |
      | 1994 |
    Then the database contains the given episodes


  Scenario: creating associated objects
    When running "ActiveCucumber.create_many(Episode, table)" with this table:
      | SHOW          | NAME                  |
      | Star Trek TNG | Encounter at Farpoint |
      | Star Trek TNG | All Good Things       |
    Then the database contains the given episodes
    And the database contains the show "Star Trek TNG"


  Scenario: creating associated objects with a nil value
    When running "ActiveCucumber.create_many(Show, table)" with this table:
      | DIRECTOR         | NAME          |
      |                  | Directionless |
      | Gene Roddenberry | Star Trek TNG |
    Then the database contains the given shows
    And "Directionless" does not have a director


  Scenario: creating associated objects that depend on other associated objects
    When running "ActiveCucumber.create_many(Episode, table)" with this table:
      | GENRE           | SHOW          | NAME                  |
      | Science Fiction | Star Trek TNG | Encounter at Farpoint |
      | Science Fiction | Star Trek TNG | All Good Things       |
    Then the database contains the shows:
      | GENRE           | NAME          |
      | Science Fiction | Star Trek TNG |
    And the database contains the episodes:
      | SHOW          | NAME                  |
      | Star Trek TNG | Encounter at Farpoint |
      | Star Trek TNG | All Good Things       |


  Scenario: using context values
    When running "ActiveCucumber.create_many(Subscription, table, context: { current_user: 'Q' })" with this table:
      | SUBSCRIBER | SHOW          |
      | me         | Star Trek TNG |
    Then the database contains the subscriptions:
      | SUBSCRIBER | SHOW          |
      | Q          | Star Trek TNG |


  Scenario: complex example
    When running "ActiveCucumber.create_many(Episode, table)" with this table:
      | SHOW          | NAME                  | YEAR |
      | Star Trek TNG | Encounter at Farpoint | 1987 |
      | Star Trek TOS | The Paradise Syndrome | 1968 |
    Then the database contains the given episodes
    And the database contains the shows "Star Trek TNG" and "Star Trek TOS"

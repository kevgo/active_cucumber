Feature: ActiveCucumber.attributes_for

  Scenario: data attributes
    When running "ActiveCucumber.attributes_for(Episode, table)" with this table:
      | NAME | Encounter at Farpoint |
    Then it returns the hash
      """
      {
        name: 'Encounter at Farpoint'
      }
      """
    And the database contains no episodes
    And the database contains no shows


  Scenario: associated objects are built
    When running "ActiveCucumber.attributes_for(Episode, table)" with this table:
      | SHOW | Star Trek TNG         |
      | NAME | Encounter at Farpoint |
    Then it returns the hash
      """
      {
        show: Show.find_by(name: 'Star Trek TNG'),
        name: 'Encounter at Farpoint'
      }
      """
    And the database contains no episodes
    And the database contains the show "Star Trek TNG"

Feature: ActiveCucumber.attributes_for

  As a developer testing my own record create code
  I want to be able to convert Cucumber tables into attribute hashes
  So that I can use ActiveCucumber to parse Cucumber tables.

  Rules:
  - ActiveCucumbe.attributes_for(Class, table) returns the attributes of the given table as a hash
  - the creator for this class is used to parse attributes in the Cucumber table
  - related objects are getting created in the database


  Scenario: data attributes
    When running "ActiveCucumber.attributes_for Episode, table" with this table:
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
    When running "ActiveCucumber.attributes_for Episode, table" with this table:
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

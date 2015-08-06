Feature: Playing a game
  Scenario: Placing ships
  Given I am on "/game"
  When I fill in "coordinate" with "A1"
  When I select "Destroyer" from "ship"
  When I choose "Horizontal"
  When I press "Submit"
  Then I should see "DD"

  Scenario: Firing
  Given I am on "gameplay"
  When I fill in "coordinate" with "A2"
  When I press "Fire!"
  Then I should see "sunk"







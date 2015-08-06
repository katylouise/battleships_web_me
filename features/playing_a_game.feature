Feature: Setting up game
  Scenario: Placing ships
  Given I am on "/game"
  When I fill in "coordinate" with "A1"
  When I select "Destroyer" from "ship"
  When I choose "Horizontal"
  When I press "Submit"
  Then I should see "DD"




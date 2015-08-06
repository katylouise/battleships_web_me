Feature: Starting the game
  In order to play battleships
  As a nostalgic player
  I want to start a new game

  Scenario: Registering
    Given I am on the homepage
    When I follow "New Game"
    Then I should see "What's your name?"

  Scenario: Entering name
    Given I am on "register"
    When I fill in "name" with "Leon"
    When I press "Submit"
    Then I should see "Welcome to Battleships Leon!"

  Scenario: Refreshes page if no input
    Given I am on "register"
    When I fill in "name" with ""
    When I press "Submit"
    Then I should see "What's your name?"









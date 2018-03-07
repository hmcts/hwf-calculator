@e2e
@javascript

Feature: Not eligible page

  Scenario: Back to start
    Given I am Tony and partner
    When I am on the not eligible page
    Then I can return to help with fees home page
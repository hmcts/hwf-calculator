Feature: Highlight Response
  Highlight disposable capital test response at response point (after question 4 form validation)

  Rules:

  If answer is a negative decision at response point, surface response highlighted in red and end the calculator session
  If answer is a positive decision at response point, surface response highlighted in blue and move user to the next question


  Personas (defined in test_common/fixtures/personas.yml)

  JOHN is a single, 56 year old man with £2,990 worth of capital. He has a court fee of £600
  LOLA is a married, 90 year old man with £19,000 worth of capital. He has a court fee of £100,000


  Messaging (defined in test_common/messaging/en.yml for english)

  Positive

  You are able to get help with fees
  Positive decision: With a fee of £XXX and savings of £XXX, you (and your partner)should be able to get help with your fees, as long as you receive certain benefits or are on a low income
  Negative

  You are unlikely to get help with your fees
  With a fee of £XXX and savings of £XXX, it is unlikely that you'll be able to get financial help,  unless you are likely to experience exceptional hardship


  Scenario: Under 61 years old view highlighted positive response

    Given I am "john"
    And I am on the savings and investment page
    And I fill in the savings and investment page
    When I click on the Next step button on the savings and investment page
    Then I should see that I am able to get help with fees
    And response highlighted in blue

  Scenario: Over 61 year old view highlighted negative response
    Given I am "lola"
    And I am on the savings and investment page
    And I fill in the savings and investment page
    When I click on the Next step button on the savings and investment page
    Then I should see that I am unlikely to get help with fees
    And response highlighted in red
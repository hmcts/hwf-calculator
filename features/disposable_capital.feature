@e2e
@javascript
Feature: Disposable Capital With Personas
  HwF eligibility Calculator will execute disposable capital test to check citizen eligibility
  Eligibility criteria for disposable capital test is specified in the legislation and threshold summary for fee exemption and fee remission outlined in the HwF Eligibility Calculator requirements page in confluence
  Rules:

  When citizen (or their partner) are 61 or over, they may have up to £16,000 in savings and investments
  When citizen (and their partner) are under 61, the maximum amount of savings and investments allowed is specified in the (see Requirements Page)
  If citizen is part of a couple and sharing an income, then their partner’s financial situation will be taken into consideration and citizen must give details of their savings and income
  Citizen must confirm their partner status, enter their court or tribunal fee, age (and partner's age), savings and investment amount into the calculator to test for disposable capital


  Personas (defined in test_common/fixtures/personas.yml)

  JOHN is a single, 56 year old man with £2,990 worth of capital. He has a court fee of £600
  ALLI is a married, 60 year old man with £3,800 worth of capital. He has a court fee of £1,334
  OLIVER is a married, 75 year old man with £15,000 worth of capital. He has a court fee of £20,000
  LOLA is a married, 90 year old man with £19,000 worth of capital. He has a court fee of £100,000
  BABA is a single, 40 year old man with £15,000 worth of capital. He has a court fee of £6,500


  Messaging (defined in test_common/messaging/en.yml for english)

  Positive

  You are able to get help with fees
  Positive decision: With a fee of £XXX and savings of £XXX you (and your partner)should be able to get help with your fees, as long as you receive certain benefits or are on a low income
  Negative

  You are unlikely to get help with your fees
  With a fee of £XXX and savings of £XXX, it is unlikely that you'll be able to get financial help,  unless you are likely to experience exceptional hardship

  Scenario: Under 61 and single pass disposable capital test
    Given I am "john"
    And I am on the savings and investment page
    And I fill in the savings and investment page
    When I click on the Next step button on the savings and investment page
    Then I should see that I am able to get help with fees

  Scenario: Under 61 and married pass disposable capital test
    Given I am "alli"
    And I am on the savings and investment page
    And I fill in the savings and investment page
    When I click on the Next step button on the savings and investment page
    Then I should see that I am able to get help with fees

  Scenario: Over 61 and married pass disposable capital test
    Given I am "oliver"
    And I am on the savings and investment page
    And I fill in the savings and investment page
    When I click on the Next step button on the savings and investment page
    Then I should see that I am able to get help with fees

  Scenario: Over 61 and married fail disposable capital test
    Given I am "lola"
    And I am on the savings and investment page
    And I fill in the savings and investment page
    When I click on the Next step button on the savings and investment page
    Then I should see that I am unlikely to get help with fees

  Scenario: Under 61 and single fail disposable capital test
    Given I am "baba"
    And I am on the savings and investment page
    And I fill in the savings and investment page
    When I click on the Next step button on the savings and investment page
    Then I should see that I am unlikely to get help with fees
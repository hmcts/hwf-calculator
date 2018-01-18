@e2e
@javascript
Feature: Disposable capital
 
  # John is a single, 56 year old man with £2,990 worth of capital. He has a court fee of £600
  Scenario: John passes disposable capital test
    Given I am John
    And I am on the savings and investment page
    When I submit my savings and investments
    Then I should see that I am likely to get help with fees

# Tom is single, 80 year old man with £15,999 worth of capital. He has a court fee of £100
  Scenario: Tom passes disposable capital test
    Given I am Tom
    And I am on the savings and investment page
    When I submit my savings and investments
    Then I should see that I am likely to get help with fees

# Alli is a married, 60 year old man with £3,800 worth of capital. He has a court fee of £1,334
  Scenario: Alli passes disposable capital test
    Given I am Alli and partner
    And I am on the savings and investment page
    When I submit our savings and investments
    Then I should see that we are likely to get help with fees

# Oliver is a married, 75 year old man with £15,000 worth of capital. He has a court fee of £20,000
  Scenario: Oliver passes disposable capital test
    Given I am Oliver
    And I am on the savings and investment page
    When I submit our savings and investments
    Then I should see that we are likely to get help with fees

# Baba is a single, 40 year old man with £15,000 worth of capital. He has a court fee of £6,500
  Scenario: Baba fails disposable capital test
    Given I am Baba
    And I am on the savings and investment page
    When I submit my savings and investments
    Then I should see that I am unlikely to get help with fees

# David is single, 62 year old man with £25,000 worth of capital. He has a court fee of £50,000 
  Scenario: David fails disposable capital test
    Given I am David
    And I am on the savings and investment page
    When I submit my savings and investments
    Then I should see that I am unlikely to get help with fees

# Lola is a married, 90 year old woman with £19,000 worth of capital. He has a court fee of £100,000
  Scenario: Lola and partner passes disposable capital test
    Given I am Lola and partner
    And I am on the savings and investment page
    When I submit our savings and investments
    Then I should see that we are unlikely to get help with fees

# Tony is a married, 59 year old man with £18,000 worth of capital. He has a court fee of £7,500
  Scenario: Tony fails disposable capital test
    Given I am Tony and partner
    And I am on the savings and investment page
    When I submit our savings and investments
    Then I should see that we are unlikely to get help with fees
    
  Scenario: Previous answer
    Given I am David
    And I am on the savings and investment page
    When I submit my savings and investments
<<<<<<< HEAD
<<<<<<< HEAD
    Then on the next page I should see my previous answer with my savings and investments
=======
    Then on the next page I should see my previous answer for savings and investments
>>>>>>> RST-730 added tests to desposable capital
=======
    Then on the next page I should see my previous answer with my savings and investments
>>>>>>> RST-730 tests in progress for num of children

  Scenario: Help with savings and investment
    Given I am David
    And I am on the savings and investment page
    When I click on help with savings and investment 
    Then I should see the copy for help with savings and investment

  Scenario: Displays savings and investment error message
    Given I am David
    And I am on the savings and investment page
    When I click next without submitting my savings and investment
    Then I should see the savings and investment error message

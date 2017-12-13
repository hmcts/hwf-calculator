@e2e
@integration
Feature: Disposable Capital
  HwF Calculator should be able to execute Disposable Capital Test to check eligibility.
  Eligibility criteria for Disposable Capital Test is specified and threshold defined for both fee exemption and fee remission in the legislation
  Rules:
  Citizen must enter their civil partnership status, court fee, age and disposable capital amount
  Disposable Capital must be for Citizen and their partners
  Response header 1:
  Negative decision: You are unlikely to get help with your fees
  Positive decision: You are likely to get help with fees
  Response header 2:
  Negative decision: With a fee of £XXX and savings of £XXX, it is unlikely that you'll be able to get financial help, unless you are likely to experience exceptional hardship
  Positive decision: With a fee of £XXX and savings of £XXX you (and your partner)should be able to get help with your fees, as long as you receive certain benefits or are on a low income

  Background:
    Given I am a calculator user

  Scenario Outline: Under 61 year old test for disposable capital of less than £3,000 and fee band of up to £1,000
    Given I am <Age> years of age
    And my court or tribunal fee is <Court Fee>
    And savings and investment amount of <Capital>
    And civil partnership status is <Marital Status>
    And I navigate to the calculator savings and investment page
    And I fill in the calculator savings and investment page
    When I click on the Next step button on the calculator savings and investment page
    Then the calculator response should be "<Response header 1> <Response header 2>"
    And savings and investment question, answer appended to the calculator Previous answers section

    Examples:
      | Marital Status | Age | Court Fee | Capital | Response header 1                           | Response header 2                                                                                                                                                         |
      | Single         | 60  | 1000      | 3000    | You are unlikely to get help with your fees | With a fee of £1,000 and savings of £3,000 it is unlikely that you'll be able to get financial help, unless you are likely to experience exceptional hardship             |
      | Married        | 39  | 600       | 2400    | You are likely to get help with fees        | With a fee of £600 and savings of £2,400 you and your partner should be able to get help with your fees, as long as you receive certain benefits or are on a low income   |
      | Single         | 59  | 999       | 4000    | You are unlikely to get help with your fees | With a fee of £999 and savings of £4,000 it is unlikely that you'll be able to get financial help, unless you are likely to experience exceptional hardship               |
      | Single         | 50  | 1000      | 5000    | You are unlikely to get help with your fees | With a fee of £1,000 and savings of £5,000 it is unlikely that you'll be able to get financial help, unless you are likely to experience exceptional hardship             |
      | Married        | 40  | 1001      | 3000    | You are likely to get help with fees        | With a fee of £1,001 and savings of £3,000 you and your partner should be able to get help with your fees, as long as you receive certain benefits or are on a low income |
      | Single         | 61  | 900       | 2900    | You are likely to get help with fees        | With a fee of £900 and savings of £2,900 you should be able to get help with your fees, as long as you receive certain benefits or are on a low income                    |
      | Single         | 62  | 600       | 2000    | You are likely to get help with fees        | With a fee of £600 and savings of £2,000 you should be able to get help with your fees, as long as you receive certain benefits or are on a low income                    |
      | Married        | 59  | 900       | 2999    | You are likely to get help with fees        | With a fee of £900 and savings of £2,999 you and your partner should be able to get help with your fees, as long as you receive certain benefits or are on a low income   |

  Scenario Outline:  Under 61 year old test for disposable capital of less than £7,000 and fee band of £2,001-£2,330
    Given I am <Age> years of age
    And my court or tribunal fee is <Court Fee>
    And savings and investment amount of <Capital>
    And civil partnership status is <Marital Status>
    And I navigate to the calculator savings and investment page
    And I fill in the calculator savings and investment page
    When I click on the Next step button on the calculator savings and investment page
    Then the calculator response should be "<Response header 1> <Response header 2>"
    And savings and investment question, answer appended to the calculator Previous answers section

    Examples:
      | Marital Status | Age | Court Fee | Capital | Response header 1                           | Response header 2                                                                                                                                                         |
      | Married        | 44  | 2001      | 6999    | You are likely to get help with fees        | With a fee of £2,001 and savings of £6,999 you and your partner should be able to get help with your fees, as long as you receive certain benefits or are on a low income |
      | Married        | 35  | 2330      | 7001    | You are unlikely to get help with your fees | With a fee of £2,330 and savings of £7,001 it is unlikely that you'll be able to get financial help, unless you are likely to experience exceptional hardship             |
      | Single         | 55  | 2000      | 5000    | You are likely to get help with fees        | With a fee of £2,000 and savings of £5,000 you should be able to get help with your fees, as long as you receive certain benefits or are on a low income                  |
      | Single         | 60  | 2329      | 6000    | You are likely to get help with fees        | With a fee of £2,329 and savings of £6,000 you should be able to get help with your fees, as long as you receive certain benefits or are on a low income                  |
      | Married        | 44  | 700       | 3000    | You are unlikely to get help with your fees | With a fee of £700 and savings of £3,000 it is unlikely that you'll be able to get financial help, unless you are likely to experience exceptional hardship               |
      | Single         | 61  | 900       | 6500    | You are likely to get help with fees        | With a fee of £900 and savings of £6,500 you should be able to get help with your fees, as long as you receive certain benefits or are on a low income                    |
      | Single         | 70  | 2330      | 7000    | You are likely to get help with fees        | With a fee of £2,330 and savings of £7,000 you should be able to get help with your fees, as long as you receive certain benefits or are on a low income                  |

  Scenario Outline:  61 year old and over test for disposable capital of less than £16,000 and fee band of any amount
    Given I am <Age> years of age
    And my court or tribunal fee is <Court Fee>
    And savings and investment amount of <Capital>
    And civil partnership status is <Marital Status>
    And I navigate to the calculator savings and investment page
    And I fill in the calculator savings and investment page
    When I click on the Next step button on the calculator savings and investment page
    Then the calculator response should be "<Response header 1> <Response header 2>"
    And savings and investment question, answer appended to the calculator Previous answers section

    Examples:
      | Marital Status | Age | Court Fee | Capital | Response header 1                           | Response header 2                                                                                                                                                |
      | Married        | 65  | 50000     | 16000   | You are unlikely to get help with your fees | With a fee of £50,000 and savings of £16,000 it is unlikely that you'll be able to get financial help, unless you are likely to experience exceptional hardship  |
      | Married        | 80  | 100000    | 16001   | You are unlikely to get help with your fees | With a fee of £100,000 and savings of £16,001 it is unlikely that you'll be able to get financial help, unless you are likely to experience exceptional hardship |
      | Single         | 70  | 45000     | 15999   | You are likely to get help with fees        | With a fee of £45,000 and savings of £15,999 you should be able to get help with your fees, as long as you receive certain benefits or are on a low income       |
      | Single         | 80  | 100       | 15000   | You are likely to get help with fees        | With a fee of £100 and savings of £15,000 you should be able to get help with your fees, as long as you receive certain benefits or are on a low income          |
      | Married        | 70  | 25000     | 25000   | You are unlikely to get help with your fees | With a fee of £25,000 and savings of £25,000 it is unlikely that you'll be able to get financial help, unless you are likely to experience exceptional hardship  |

  Scenario: DEVELOPMENT
    Given I am 60 years of age
    And my court or tribunal fee is 1000
    And savings and investment amount of 3000
    And civil partnership status is Single
    And I navigate to the calculator savings and investment page
    And I fill in the calculator savings and investment page
    When I click on the Next step button on the calculator savings and investment page
    Then the calculator response should be "You are unlikely to get help with your fees With a fee of £1,000 and savings of £3,000 it is unlikely that you'll be able to get financial help, unless you are likely to experience exceptional hardship"
    And savings and investment question, answer appended to the calculator Previous answers section
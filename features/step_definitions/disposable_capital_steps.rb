include ActiveSupport::NumberHelper

Then(/^I should see that (?:I am|we are) likely to get help with fees$/) do
  marital_status = user.marital_status.downcase
  msg = messaging.translate("hwf_decision.disposable_capital.#{marital_status}.positive.detail",
    fee: number_to_currency(user.fee, precision: 0, unit: '£'),
    disposable_capital: number_to_currency(user.disposable_capital, precision: 0, unit: '£'))
  expect(any_calculator_page.feedback_message_with_header(messaging.translate("hwf_decision.disposable_capital.#{marital_status}.positive.heading"))).to be_present
  expect(any_calculator_page.feedback_message_with_detail(msg)).to be_present
end

Then(/^I should see that (?:I am|we are) unlikely to get help with fees$/) do
  marital_status = user.marital_status.downcase
  msg = messaging.translate("hwf_decision.disposable_capital.#{marital_status}.negative.detail",
    fee: number_to_currency(user.fee, precision: 0, unit: '£'),
    disposable_capital: number_to_currency(user.disposable_capital, precision: 0, unit: '£'))
  expect(any_calculator_page.feedback_message_with_detail(msg)).to be_present
  expect(any_calculator_page.feedback_message_with_header(messaging.translate("hwf_decision.disposable_capital.#{marital_status}.negative.heading"))).to be_present
end

Given(/^I am on the savings and investment page$/) do
  step 'I start a new calculator session'
  step 'I answer the marital status question'
  step 'I answer the court fee question'
  step 'I answer the date of birth question'
end

And(/^I submit (?:my|our) savings and investments$/) do
  answer_disposable_capital_question
end

And(/^on the next page I should see my previous answer with (?:my|our) savings and investments$/) do
  expect(any_calculator_page.previous_answers.disposable_capital.answer.text).to eql number_to_currency(user.disposable_capital, precision: 0, unit: '£')
end

When("I click on help with savings and investment") do
  # TODO: add when functionality is complete
end

Then("I should see the copy for help with savings and investment") do
  # TODO: add when functionality is complete
end

When("I click next without submitting my savings and investment") do
  disposable_capital_page.next
end

Then("I should see the savings and investment error message") do
  expect(disposable_capital_page.error_with_text(messaging.t('hwf_pages.disposable_capital.errors.blank'))).to be_present
end


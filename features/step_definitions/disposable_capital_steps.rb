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
  expect(not_eligible_page).to be_displayed
  expect(not_eligible_page.feedback_message_with_detail(msg)).to be_present
  expect(not_eligible_page.feedback_message_with_header(messaging.translate("hwf_decision.disposable_capital.#{marital_status}.negative.heading"))).to be_present
end

Given(/^I am on the savings and investment page$/) do
  answer_up_to(:disposable_capital)
end

And(/^I submit (?:my|our) savings and investments$/) do
  answer_disposable_capital_question
end

And(/^on the next page (?:my|our) savings and investments have been added to previous answers$/) do
  expect(full_remission_page.previous_answers).to have_marital_status
  expect(full_remission_page.previous_answers).to have_court_fee
  expect(full_remission_page.previous_answers).to have_date_of_birth
  expect(full_remission_page.previous_answers).to have_disposable_capital
end

When(/^I click on help with savings and investment$/) do
  disposable_capital_page.toggle_guidance
end

Then(/^I should see the copy for help with savings and investment$/) do
  disposable_capital_page.validate_guidance
end

When(/^I click next without submitting my savings and investment$/) do
  disposable_capital_page.next
end

Then(/^I should see the savings and investment error message$/) do
  expect(disposable_capital_page.error_with_text(messaging.t('hwf_pages.disposable_capital.errors.blank'))).to be_present
end

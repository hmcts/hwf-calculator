And(/^I answer the court fee question$/) do
  court_fee_page.fee.set(user.fee)
  court_fee_page.next
end

Given(/^I am on the court and tribunal fee page$/) do
  answer_up_to(:court_fee)
end

When(/^I successfully submit my court and tribunal fee$/) do
  answer_court_fee_question
end

Then(/^on the next page my court and tribunal fee has been added to previous answers$/) do
  expect(date_of_birth_page.previous_answers).to have_marital_status
  expect(date_of_birth_page.previous_answers).to have_court_fee
end

When(/^I click on if you have already paid your court or tribunal fee$/) do
  court_fee_page.toggle_guidance
end

Then(/^I should see the copy for if you have already paid your court or tribunal fee$/) do
  court_fee_page.validate_guidance
end

When(/^I click next without submitting my court and tribunal fee$/) do
  court_fee_page.next
end

Then(/^I should see the court and tribunal fee error message$/) do
  expect(court_fee_page.error_with_text(messaging.t('hwf_pages.fee.errors.non_numeric'))).to be_present
end

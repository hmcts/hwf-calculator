And(/^I answer the marital status question$/) do
  marital_status_page.marital_status.set(user.marital_status)
  marital_status_page.next
end

Given(/^I am on the marital status page$/) do
  step 'I start a new calculator session'
end

When(/^I successfully submit my marital status as single$/) do
  answer_marital_status_question
end

Then(/^on the next page my marital status has been added to previous answers$/) do
  expect(court_fee_page.previous_answers).to have_marital_status
end

When(/^I successfully submit my marital status as married$/) do
  answer_marital_status_question
end

When(/^I click on help with status$/) do
  marital_status_page.toggle_guidance
end

Then(/^I should see the copy for help with status$/) do
  marital_status_page.validate_guidance
end

When(/^I click next without submitting my marital status$/) do
  marital_status_page.next
end

Then(/^I should see the marital status error message$/) do
  expect(marital_status_page.marital_status).to have_error_blank
end

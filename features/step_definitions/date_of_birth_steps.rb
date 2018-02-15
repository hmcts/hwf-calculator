And(/^I answer the date of birth question$/) do
  answer_date_of_birth_question
end

Given(/^I am on the date of birth page$/) do
  answer_up_to(:date_of_birth)
end

When(/^I successfully submit my date of birth$/) do
  answer_date_of_birth_question
end

Then(/^on the next page our date of births have been added to previous answers$/) do
  expect(disposable_capital_page.previous_answers.marital_status).to have_answered(user.marital_status)
  expect(disposable_capital_page.previous_answers.court_fee).to have_answered(user.fee)
  expect(disposable_capital_page.previous_answers.date_of_birth).to have_answered(user.date_of_birth)
  expect(disposable_capital_page.previous_answers.partner_date_of_birth).to have_answered(user.partner_date_of_birth)
end

When(/^I successfully submit our date of births$/) do
  expect(date_of_birth_page.partner_date_of_birth).to be_present
  answer_date_of_birth_question
end

Then(/^on the next page my date of birth has been added to previous answers$/) do
  expect(disposable_capital_page.previous_answers.marital_status).to have_answered(user.marital_status)
  expect(disposable_capital_page.previous_answers.court_fee).to have_answered(user.fee)
  expect(disposable_capital_page.previous_answers.date_of_birth).to have_answered(user.date_of_birth)
  expect(disposable_capital_page.previous_answers).to have_no_partner_date_of_birth
end

When(/^I click next without submitting our date of birth$/) do
  date_of_birth_page.next
end

Then(/^I should see the date of birth error messages$/) do
  expect(date_of_birth_page.date_of_birth).to have_error_non_numeric
  expect(date_of_birth_page.partner_date_of_birth).to have_error_non_numeric
end

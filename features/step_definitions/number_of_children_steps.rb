Given(/^I am on the number of children page$/) do
  answer_up_to(:number_of_children)
end

When(/^I successfully submit my number of children$/) do
  number_of_children_page.number_of_children.set(user.number_of_children)
  number_of_children_page.next
end

Then(/^on the next page our number of children has been added to previous answers$/) do
  expect(total_income_page.previous_answers.marital_status).to have_answered(user.marital_status)
  expect(total_income_page.previous_answers.court_fee).to have_answered(user.fee)
  expect(total_income_page.previous_answers.date_of_birth).to have_answered(user.date_of_birth)
  expect(total_income_page.previous_answers.partner_date_of_birth).to have_answered(user.partner_date_of_birth)
  expect(total_income_page.previous_answers.disposable_capital).to have_answered(user.disposable_capital)
  expect(total_income_page.previous_answers.income_benefits).to have_answered(user.income_benefits)
  expect(total_income_page.previous_answers.number_of_children).to have_answered(user.number_of_children)
end

When(/^I click on children who might affect your claim$/) do
  number_of_children_page.toggle_guidance
end

Then(/^I should see the copy for children who might affect your claim$/) do
  number_of_children_page.validate_guidance
end

When(/^I click next without submitting my number of children$/) do
  number_of_children_page.next
end

Then(/^I should see the number of children error message$/) do
  expect(number_of_children_page.number_of_children).to have_error_blank
end

When(/^I click on change for marital status$/) do
  number_of_children_page.go_back_to_question(:marital_status)
end

Then(/^I should be taken back to the marital status page$/) do
  expect(marital_status_page).to be_displayed
end

Then(/^I should see my other previous answers have been saved$/) do
  expect(marital_status_page.previous_answers).to have_no_marital_status
  expect(marital_status_page.previous_answers).to have_court_fee
  expect(marital_status_page.previous_answers).to have_date_of_birth
  expect(marital_status_page.previous_answers).to have_partner_date_of_birth
  expect(marital_status_page.previous_answers).to have_disposable_capital
  expect(marital_status_page.previous_answers).to have_income_benefits
end

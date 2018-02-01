Given(/^I am on the number of children page$/) do
  answer_up_to(:number_of_children)
end

When(/^I successfully submit my number of children$/) do
  number_of_children_page.number_of_children.set(user.number_of_children)
  number_of_children_page.next
end

Then(/^on the next page our number of children has been added to previous answers$/) do
  expect(total_income_page.previous_answers).to have_marital_status
  expect(total_income_page.previous_answers).to have_court_fee
  expect(total_income_page.previous_answers).to have_date_of_birth
  expect(total_income_page.previous_answers).to have_partner_date_of_birth
  expect(total_income_page.previous_answers).to have_income_benefits
  expect(total_income_page.previous_answers).to have_number_of_children
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
  expect(number_of_children_page.error_with_text(messaging.t('hwf_pages.number_of_children.errors.blank'))).to be_present
end

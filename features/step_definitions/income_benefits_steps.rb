Given(/^I am on the income benefits page$/) do
  step 'I am John'
  answer_questions_up_to_benefits
  expect(income_benefits_page.heading).to be_present
  expect(income_benefits_page.benefits).to be_present
end

Then(/^I should see that I should be able to get help with fees message$/) do
  expect(any_calculator_page.positive_message).to be_present
end

Then(/^I should see income benefits list$/) do
  expect(income_benefits_page.benefit_options).to be_present
end

When(/^I select none of the above$/) do
  income_benefits_page.choose_none
end

When(/^I answer the income benefits question$/) do
  answer_benefits_question
end

Then(/^I should see the none of the above guidance information$/) do
  expect(income_benefits_page.none_of_the_above_guidance).to be_present
end

When(/^I select dont know$/) do
  income_benefits_page.choose_dont_know
end

Then(/^I should see the dont know guidance information$/) do
  expect(income_benefits_page.dont_know_guidance).to be_present
end

When(/^I submit the page with income related benefit checked$/) do
  income_benefits_page.choose_jobseekers_allowance
  income_benefits_page.next
end

Then(/^I should see that I should be eligible for a full remission$/) do
  expect(current_path).to end_with '/full_remission_available'
  expect(full_remission_page).to be_displayed
end

When(/^I submit the page with income support and universal credit$/) do
  income_benefits_page.choose_income_support
  income_benefits_page.choose_universal_credit
  income_benefits_page.next
end

When(/^I click next without submitting my income benefits$/) do
  income_benefits_page.next
end

Then(/^I should see the income benefits error message$/) do
  expect(income_benefits_page.error_nothing_selected).to be_visible
end

When(/^I submit the page with income support$/) do
  income_benefits_page.choose_income_support
  income_benefits_page.next
end

Then(/^on the next page I should see my previous answer is income support$/) do
  # TODO: add when functionality is complete
end

When(/^I click on how benefits affect your claim$/) do
  income_benefits_page.toggle_guidance
end

Then(/^I should see the copy for how benefits affect your claim$/) do
  expect(income_benefits_page.validate_guidance).to be true
end

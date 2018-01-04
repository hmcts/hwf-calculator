Given("I am on the income benefits page") do
  step 'I am John'
  step 'I start a new calculator session'
  step 'I answer the marital status question'
  step 'I answer the court fee question'
  step 'I answer the date of birth question'
  step 'I submit my savings and investments'
end

Then("I should see that I should be able to get help with fees message") do
  expect(income_benefits_page).to have_positive_eligibility_header
  expect(income_benefits_page).to have_johns_eligibility_message
end

Then("I should see income benefits list") do
  expect(income_benefits_page).to have_jobseekers_allowance
  expect(income_benefits_page).to have_employment_support_allowance
  expect(income_benefits_page).to have_income_support
  expect(income_benefits_page).to have_universal_credit
  expect(income_benefits_page).to have_pension_credit
  expect(income_benefits_page).to have_scottish_legal_aid
end

Given("I select income-based jobseekers allowance") do
  income_benefits_page.jobseekers_allowance.click
end

When("I select none of the above") do
  income_benefits_page.none_of_the_above.click
end

Then("I should see the none of the above guidance information") do
  expect(income_benefits_page).to have_prefix_none
end

When("I select dont know") do
  income_benefits_page.dont_know.click
end

Then("I should see the dont know guidance information") do
  expect(income_benefits_page).to have_prefix_dont_know
end

When("I submit the page with income related benefit checked") do
  income_benefits_page.employment_support_allowance.click
  income_benefits_page.next
end

Then("I should see that I should be eligible for a full remission") do
  expect(current_path).to end_with '/full_remission_available'
  expect(full_remission_page).to have_positive
end

When("I submit the page with income support") do
  income_benefits_page.income_support.click
  income_benefits_page.next
end

Then("on the next page I should see my previous answer is income support") do
  expect(full_remission_page).to have_previous_question
end

When("I click next without submitting my income benefits") do
  income_benefits_page.next
end

Then("I should see the income benefits error message") do
  expect(income_benefits_page).to have_error_message
end

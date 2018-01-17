And(/^I answer the date of birth question$/) do
  answer_date_of_birth_question
end

Given("I am on the date of birth page") do
  step 'I start a new calculator session'
  step 'I answer the marital status question'
  step 'I answer the court fee question'
end

When("I sucessfully submit my date of birth") do
  answer_date_of_birth_question
end

Then("on the next page I should see my previous answer with my date of birth") do
  # TODO: add when functionality is complete
end

When("I sucessfully submit our date of births") do
  answer_date_of_birth_question
end

Then("on the next page I should see my previous answer with our date of births") do
  # TODO: add when functionality is complete
end

When("I click next without submitting my date of birth") do
  date_of_birth_page.next
end

Then("I should see the date of birth error message") do
  expect(date_of_birth_page.date_of_birth.error_with_text(messaging.t('hwf_pages.date_of_birth.errors.non_numeric'))).to be_present
end

And(/^I answer the court fee question$/) do
  court_fee_page.fee.set(user.fee)
  court_fee_page.next
end

Given("I am on the court and tribunal fee page") do
  step 'I am John'
  step 'I start a new calculator session'
  step 'I answer the marital status question'
end

When("I see the court and tribunal question") do
  expect(court_fee_page).to have_fee
end

When("I successfully submit my court and tribunal fee") do
  answer_court_fee_question
end

<<<<<<< HEAD
Then("on the next page I should see my answer for court and tribunal fee") do
=======
Then("on the next page I should see my previous answer is the same") do
>>>>>>> RST-730 wip tests
  # TODO: add when functionality is complete
end

When("I click on if you have already paid your court or tribunal fee") do
  # TODO: add when functionality is complete
end

Then("I should see the copy for if you have already paid your court or tribunal fee") do
  # TODO: add when functionality is complete
end

When("I click next without submitting my court and tribunal fee") do
  court_fee_page.next
end

Then("I should see the court and tribunal fee error message") do
  expect(court_fee_page.error_with_text(messaging.t('hwf_pages.fee.errors.non_numeric'))).to be_present
end


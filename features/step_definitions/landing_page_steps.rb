Given("I am on the landing page") do
  load_start_page
end

Then("I should see information about the help with fees calculator") do
  expect(start_page).to have_heading
  expect(start_page.validate_introduction).to be true
  expect(start_page.validate_requirements).to be true
  expect(start_page.validate_disclaimer).to be true
  expect(start_page.validate_welsh_link).to be true
end

When("I click on start now") do
  start_page.start_session
end

Then("I am taken to the next page") do
  expect(marital_status_page).to be_displayed
end

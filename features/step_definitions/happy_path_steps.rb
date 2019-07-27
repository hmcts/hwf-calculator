When(/^I succesfully answer all the questions$/) do
  answer_up_to(:disposable_capital)
  answer_disposable_capital_question
end

Then(/^I can return to help with fees homepage$/) do
  not_eligible_page.start_again
  expect(start_page).to be_displayed
end

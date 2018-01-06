And(/^I start a new calculator session$/) do
  calculator_start_page.load_page
  calculator_start_page.start_session
end

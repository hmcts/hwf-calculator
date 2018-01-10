And(/^I start a new calculator session$/) do
  start_page.load_page
  start_page.start_session
end

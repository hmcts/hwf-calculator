And(/^I answer the marital status question$/) do
  calculator_marital_status_page.marital_status.set(user.marital_status)
  calculator_marital_status_page.next
end

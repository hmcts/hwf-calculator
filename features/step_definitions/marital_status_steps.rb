And(/^I answer the marital status question$/) do
  marital_status_page.marital_status.set(user.marital_status)
  marital_status_page.next
end

And(/^I answer the court fee question$/) do
  court_fee_page.fee.set(user.fee)
  court_fee_page.next
end

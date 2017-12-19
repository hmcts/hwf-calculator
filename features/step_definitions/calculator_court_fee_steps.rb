And(/^I answer the court fee question$/) do
  calculator_court_fee_page.fee.set(user.fee)
  calculator_court_fee_page.next
end

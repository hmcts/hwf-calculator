And(/^I answer the date of birth question$/) do
  calculator_date_of_birth_page.date_of_birth.set(user.date_of_birth)
  calculator_date_of_birth_page.next
end

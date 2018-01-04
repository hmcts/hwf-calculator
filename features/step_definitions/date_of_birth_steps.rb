And(/^I answer the date of birth question$/) do
  date_of_birth_page.date_of_birth.set(user.date_of_birth)
  date_of_birth_page.next
end

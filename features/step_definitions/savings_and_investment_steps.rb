And(/^I fill in the calculator savings and investment page$/) do
  calculator_total_savings_page.total_savings.set(user.total_savings)
end

When(/^I click on the Next step button on the calculator savings and investment page$/) do
  calculator_total_savings_page.next
end

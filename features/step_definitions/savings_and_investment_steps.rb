And(/^I fill in the calculator savings and investment page$/) do
  calculator_disposable_capital_page.disposable_capital.set(user.disposable_capital)
end

When(/^I click on the Next step button on the calculator savings and investment page$/) do
  calculator_disposable_capital_page.next
end

And(/^I submit (?:my|our) savings and investments$/) do
  calculator_disposable_capital_page.disposable_capital.set(user.disposable_capital)
  calculator_disposable_capital_page.next
end

# When(/^I click on the Next step button on the savings and investment page$/) do
#   calculator_disposable_capital_page.next
# end

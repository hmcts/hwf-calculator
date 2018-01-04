And(/^I submit (?:my|our) savings and investments$/) do
  calculator_disposable_capital_page.disposable_capital.set(user.disposable_capital)
  calculator_disposable_capital_page.next
end

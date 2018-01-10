And(/^I submit (?:my|our) savings and investments$/) do
  disposable_capital_page.disposable_capital.set(user.disposable_capital)
  disposable_capital_page.next
end

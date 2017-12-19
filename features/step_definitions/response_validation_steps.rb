include ActiveSupport::NumberHelper
Then(/^the calculator response should be "([^"]*)"$/) do |msg|
  expect(any_calculator_page.feedback_message_saying(msg)).to be_present
end

And(/^savings and investment question, answer appended to the calculator Previous answers section$/) do
  expect(any_calculator_page.previous_answers.disposable_capital.answer.text).to eql number_to_currency(user.disposable_capital, precision: 0, unit: '£')
end

Then(/^I should see that I am able to get help with fees$/) do
  marital_status = user.marital_status.downcase
  msg = messaging.translate("hwf_decision.disposable_capital.#{marital_status}.positive.heading") +
        ' ' +
        messaging.translate("hwf_decision.disposable_capital.#{marital_status}.positive.detail",
          fee: number_to_currency(user.fee, precision: 0, unit: '£'),
          disposable_capital: number_to_currency(user.disposable_capital, precision: 0, unit: '£'))
  expect(any_calculator_page.feedback_message_saying(msg)).to be_present
end

Then(/^I should see that I am unlikely to get help with fees$/) do
  marital_status = user.marital_status.downcase
  msg = messaging.translate("hwf_decision.disposable_capital.#{marital_status}.negative.heading") +
        ' ' +
        messaging.translate("hwf_decision.disposable_capital.#{marital_status}.negative.detail",
          fee: number_to_currency(user.fee, precision: 0, unit: '£'),
          disposable_capital: number_to_currency(user.disposable_capital, precision: 0, unit: '£'))
  expect(any_calculator_page.feedback_message_saying(msg)).to be_present
end


And(/^response highlighted in blue$/) do
  expect(any_calculator_page.positive_message).to be_present
end

And(/^response highlighted in red$/) do
  expect(any_calculator_page.negative_message).to be_present
end
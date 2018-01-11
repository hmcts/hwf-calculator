Given(/^I am a calculator user$/) do
  self.user = OpenStruct.new
end

Given(/^I am (.*) years of age$/) do |age|
  user.date_of_birth = (age.to_i.years.ago - 10.days).strftime('%-d/%-m/%Y')
end

And(/^my court or tribunal fee is (.*)$/) do |fee|
  user.fee = fee
end

And(/^savings and investment amount of (.*)$/) do |capital|
  user.disposable_capital = capital
end

And(/^civil partnership status is (.*)$/) do |status|
  user.marital_status = status
end

Given(/^I am ([A-Z][a-z]+).*$/) do |name|
  given_i_am(name.downcase.to_sym)
end

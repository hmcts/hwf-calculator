Given(/^I am on the number of children page$/) do
  step 'I am Claude and partner'
  answer_up_to(:number_of_children)
  expect(number_of_children_page.heading).to be_present
  expect(number_of_children_page.number_of_children).to be_present
end

When(/^I successfully submit my number of children$/) do
  number_of_children_page.number_of_children.set(user.number_of_children)
  number_of_children_page.next
end

Then(/^on the next page I should see my previous answer with our number of children$/) do
  # TODO: add when functionality is complete
end

When(/^I click on children who might affect your claim$/) do
  number_of_children_page.toggle_guidance
end

Then(/^I should see the copy for children who might affect your claim$/) do
  number_of_children_page.validate_guidance
end

When(/^I click next without submitting my number of children$/) do
  number_of_children_page.next
end

Then(/^I should see the number of children error message$/) do
  expect(number_of_children_page.error_with_text(messaging.t('hwf_pages.number_of_children.errors.blank'))).to be_present
end

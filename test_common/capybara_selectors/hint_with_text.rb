# This selector matches a question hint with text matching one or more
# of the provided I18n keys (can be single string or an array of strings)
Capybara.add_selector(:hint_with_text) do
  xpath do |locator, _options|
    XPath.generate do |x|
      i18n = Calculator::Test::Messaging.instance
      locators = Array(locator).dup
      contents = x.string.n.is(i18n.translate(locators.shift))
      contents = contents.or x.string.n.is(i18n.translate(locators.shift)) until locators.empty?
      x.css('.form-hint')[contents]
    end
  end
end

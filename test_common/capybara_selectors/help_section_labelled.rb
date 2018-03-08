# This selector matches a 'next steps' section which are present on
# final decision pages
Capybara.add_selector(:help_section_labelled) do
  xpath do |locator, _options|
    translated = Calculator::Test::Messaging.instance.t(locator)
    XPath.generate do |x|
      x.descendant[x.attr(:'data-behavior').is('help_section') & x.child(:h2)[x.string.n.is(translated)]]
    end
  end
end

# This selector matches a 'next steps' section which are present on
# final decision pages
Capybara.add_selector(:next_steps_labelled) do
  xpath do |locator, _options|
    XPath.generate do |x|
      x.descendant[x.child(:h2)[x.string.n.is(locator)]]
    end
  end
end

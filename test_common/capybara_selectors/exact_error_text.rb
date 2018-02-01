Capybara.add_selector(:exact_error_text) do
  xpath do |locator, _options|
    XPath.generate do |x|
      x.descendant(:span)[x.string.n.is(locator)]["contains(concat(' ',normalize-space(@class),' '),' error-message ')"]
    end
  end
end

Capybara.add_selector(:table_with_header) do
  xpath do |locator, _options|
    XPath.generate do |x|
      x.descendant(:table)[x.descendant(:th)[x.string.n.is(locator)]]
    end
  end
end

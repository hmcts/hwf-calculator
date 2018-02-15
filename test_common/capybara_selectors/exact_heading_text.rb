Capybara.add_selector(:exact_heading_text) do
  xpath do |locator, _options|
    XPath.generate do |x|
      x.descendant(:h1)[x.attr(:'data-behavior').is('heading') & x.string.n.is(locator)]
    end
  end
end

Capybara.add_selector(:calculator_previous_question) do
  xpath do |locator, _options|
    XPath.generate { |x| x.descendant[x.attr(:'data-behavior').equals('calculator_previous_question') & x.child[x.attr(:'data-behavior').equals('question') & x.string.n.is(locator)]] }
  end
end

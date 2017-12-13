Capybara.add_selector(:calculator_question) do
  xpath do |locator, _options|
    XPath.generate { |x| x.descendant(:div)[x.attr(:class).contains('form-group') & x.child(:fieldset)[x.descendant(:legend)[x.string.n.is(locator)]]] }
  end
end

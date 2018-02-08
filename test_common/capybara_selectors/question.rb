# This selector matches a calculator question which is labelled by one or more
# of the provided locators (can be single string or an array of strings)
Capybara.add_selector(:calculator_question) do
  xpath do |locator, _options|
    XPath.generate do |x|
      locators = Array(locator).dup
      legends = x.string.n.is(locators.shift)
      until locators.empty? do
        legends = legends.or x.string.n.is(locators.shift)
      end
      x.descendant(:div)[x.attr(:class).contains('form-group') &
        x.child(:fieldset)[x.descendant(:legend)[legends]]]
    end
  end
end

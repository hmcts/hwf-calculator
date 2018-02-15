Capybara.add_selector(:gds_multiple_choice_option) do
  xpath do |locator, _options|
    if locator.present?
      XPath.generate { |x| x.css('.multiple-choice')[x.descendant(:label)[x.string.n.is(locator)]] }
    else
      XPath.generate { |x| x.css('.multiple-choice') }
    end
  end
end

Capybara.add_selector(:gds_multiple_choice_option) do
  css do |_locator, _options|
    '.multiple-choice'
  end
end

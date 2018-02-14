Capybara.add_selector(:guidance_section_labelled) do
  xpath do |locator, _options|
    XPath.generate do |x|
      x.descendant(:details)[x.attr(:'data-behavior').is('question_help') &
                             x.descendant(:summary)[x.string.n.is(locator)]]
    end
  end
end

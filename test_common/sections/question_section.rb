module Calculator
  module Test
    class QuestionSection < BaseSection
      element :hint, '.form-hint'
      # Finds an error node with the matching text which is GDS compatible
      # @param [String] text The error text to search for
      # @return [Capybara::Node::Element] The node containing the error message
      # @raise [Capybara::ElementNotFound] If a node containing the exact error message was not found
      def error_with_text(text)
        # Important, do not be tempted to change this to a css selector with text: text - as it matches
        # partial text, not exact
        xpath = XPath.generate { |x| x.descendant(:span)[x.string.n.is(text)] }
        within @root_element do
          find(:xpath, xpath, class: 'error-message', exact: true)
        end
      end

      def hint_with_text(text)
        hint(text: text)
      end
    end
  end
end

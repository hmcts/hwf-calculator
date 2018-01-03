module Calculator
  module Test
    class QuestionSection < BaseSection

      # Finds an error node with the matching text which is GDS compatible
      # @param [String] text The error text to search for
      # @return [Capybara::Node::Element] The node containing the error message
      def error_with_text(text)
        find('.error-message', text: text)
      end
    end
  end
end

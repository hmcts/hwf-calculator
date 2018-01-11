module Calculator
  module Test
    module En
      class NumberOfChildrenPage < BasePage
        set_url '/calculation/number_of_children'
        section :number_of_children, ::Calculator::Test::QuestionNumericSection, :calculator_question, 'How many children live with you or are you responsible for supporting financially?'
        element :next_button, :button, 'Next step'

        # Progress to the next page
        def next
          next_button.click
        end

        # Find an error matching the given text in the number_of_children field
        #
        # @param [String] text The error message to match
        #
        # @return [Capybara::Node::Element] The node found
        # @raise [Capybara::ElementNotFound] If an error message could not be found
        def error_with_text(text)
          number_of_children.error_with_text(text)
        end
      end
    end
  end
end

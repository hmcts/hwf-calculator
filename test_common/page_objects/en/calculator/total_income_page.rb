module Calculator
  module Test
    module En
      class TotalIncomePage < BasePage
        set_url '/calculation/total_income'
        section :total_income, ::Calculator::Test::QuestionNumericSection, :calculator_question, 'How much total income do you receive each month?'
        element :next_button, :button, 'Next step'

        def next
          next_button.click
        end
        # Find an error matching the given text in the total_income field
        #
        # @param [String] text The error message to match
        #
        # @return [Capybara::Node::Element] The node found
        # @raise [Capybara::ElementNotFound] If an error message could not be found
        def error_with_text(text)
          total_income.error_with_text(text)
        end
      end
    end
  end
end

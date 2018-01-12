module Calculator
  module Test
    module En
      class NumberOfChildrenPage < BasePage
        set_url '/calculation/number_of_children'
        element :heading, :exact_heading_text, 'Find out if you can get help with fees'
        section :number_of_children, ::Calculator::Test::NumberOfChildrenQuestionSection, :calculator_question, 'How many children live with you or are you responsible for supporting financially?'
        element :next_button, :button, 'Next step'

        # Progress to the next page
        def next
          next_button.click
        end

        # Toggles the guidance text for this question
        def toggle_guidance
          number_of_children.toggle_help
        end

        # Validates that the guidance text is correct for the english language
        # @raise [Capybara::ExpectationNotMet] if the text wasn't found in the correct place
        def validate_guidance
          number_of_children.validate_guidance(messaging.t('hwf_pages.number_of_children.guidance.number_of_children.text'))
        end

        # Indicates if the marital status field has no guidance text visible
        def has_no_guidance?
          number_of_children.has_no_help_text?
        end

        # Waits for the guidance to be visible
        # @raise [Capybara::ExpectationNotMet] if the guidance never became visible in the allowed timeout
        def wait_for_guidance
          number_of_children.wait_for_help_text
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

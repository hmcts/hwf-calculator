module Calculator
  module Test
    module En
      class CourtFeePage < BasePage
        set_url '/calculation/fee'
        element :heading, :exact_heading_text, 'Find out if you could get help with fees'
        section :fee, ::Calculator::Test::CourtFeeQuestionSection, :calculator_question, 'How much is the court or tribunal fee you have to pay (or have paid within the last 3 months)?'
        element :next_button, :button, 'Next step'

        # Progress to the next page
        def next
          next_button.click
        end

        # Toggles the guidance text for this question
        def toggle_guidance
          fee.toggle_help
        end

        # Validates that the guidance text is correct for the english language
        # @raise [Capybara::ExpectationNotMet] if the text wasn't found in the correct place
        def validate_guidance
          fee.validate_guidance(messaging.t('hwf_pages.fee.guidance.fee.text'))
        end

        # Indicates if the marital status field has no guidance text visible
        def has_no_guidance?
          fee.has_no_help_text?
        end

        # Waits for the guidance to be visible
        # @raise [Capybara::ExpectationNotMet] if the guidance never became visible in the allowed timeout
        def wait_for_guidance
          fee.wait_for_help_text
        end

        # Find an error matching the given text in the fee field
        #
        # @param [String] text The error message to match
        #
        # @return [Capybara::Node::Element] The node found
        # @raise [Capybara::ElementNotFound] If an error message could not be found
        def error_with_text(text)
          fee.error_with_text(text)
        end
      end
    end
  end
end

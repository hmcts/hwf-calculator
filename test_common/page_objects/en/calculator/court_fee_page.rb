module Calculator
  module Test
    module En
      class CourtFeePage < BasePage
        set_url '/calculation/fee'
        element :heading, :exact_heading_text, t('hwf_pages.fee.heading')
        section :fee, :calculator_question, t('hwf_pages.fee.questions.fee.label') do
          include ::Calculator::Test::CourtFeeQuestionSection
        end
        element :next_button, :button, t('hwf_pages.fee.buttons.next')

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

        delegate :has_error_with_text?, to: :fee
      end
    end
  end
end

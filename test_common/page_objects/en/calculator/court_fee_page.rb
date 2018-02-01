module Calculator
  module Test
    module En
      class CourtFeePage < BasePage
        set_url '/calculation/fee'
        element :heading, :exact_heading_text, t('hwf_pages.fee.heading')
        section :fee, :calculator_question, t('hwf_pages.fee.questions.fee.label') do
          @i18n_scope = 'hwf_pages.fee.questions.fee'
          include ::Calculator::Test::CourtFeeQuestionSection
        end
        element :next_button, :button, t('hwf_pages.fee.buttons.next')

        # Progress to the next page
        def next
          next_button.click
        end

        # Toggles the guidance text for this question
        def toggle_guidance
          fee.toggle_guidance
        end

        # Validates that the guidance text is correct for the english language
        # @raise [Capybara::ExpectationNotMet] if the text wasn't found in the correct place
        def validate_guidance
          fee.validate_guidance
        end

        # Indicates if the court fee field has no guidance text visible
        def has_no_guidance?
          fee.has_no_guidance_text?
        end

        # Waits for the guidance to be visible
        # @raise [Capybara::ExpectationNotMet] if the guidance never became visible in the allowed timeout
        def wait_for_guidance
          fee.wait_for_guidance_text
        end
      end
    end
  end
end

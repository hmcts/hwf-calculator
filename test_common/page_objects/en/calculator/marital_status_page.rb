module Calculator
  module Test
    module En
      class MaritalStatusPage < BasePage
        set_url '/calculation/marital_status'
        element :heading, :exact_heading_text, t('hwf_pages.marital_status.heading')
        section :marital_status, :calculator_question, t('hwf_pages.marital_status.questions.marital_status.label') do
          @i18n_scope = 'hwf_pages.marital_status.questions.marital_status'
          include ::Calculator::Test::MaritalStatusQuestionSection
        end
        element :next_button, :button, t('hwf_pages.marital_status.buttons.next')

        # Progress to the next page
        def next
          next_button.click
        end

        # Toggles the guidance text for this question
        def toggle_guidance
          marital_status.toggle_help
        end

        # Validates that the guidance text is correct for the english language
        # @raise [Capybara::ExpectationNotMet] if the text wasn't found in the correct place
        def validate_guidance
          marital_status.validate_guidance
        end

        # Indicates if the marital status field has no guidance text visible
        def has_no_guidance?
          marital_status.has_no_help_text?
        end

        # Waits for the guidance to be visible
        # @raise [Capybara::ExpectationNotMet] if the guidance never became visible in the allowed timeout
        def wait_for_guidance
          marital_status.wait_for_help_text
        end
      end
    end
  end
end

module Calculator
  module Test
    module En
      class MaritalStatusPage < BasePage
        set_url '/calculation/marital_status'
        element :heading, :exact_heading_text, 'Find out if you can get help with fees'
        section :marital_status, ::Calculator::Test::MaritalStatusQuestionSection, :calculator_question, 'Are you single, married or living with someone and sharing an income?'
        element :next_button, :button, 'Next step'

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
          marital_status.validate_guidance(messaging.t('hwf_pages.marital_status.guidance.marital_status.text'))
        end

        # Indicates if the marital status field has no guidance text visible
        def has_no_guidance?
          marital_status.has_no_help_text?
        end

        def wait_for_guidance
          marital_status.wait_for_help_text
        end

        def wait_until_guidance_invisible
          marital_status.wait_until_help_text_invisible
        end
      end
    end
  end
end

module Calculator
  module Test
    module En
      class DisposableCapitalPage < BasePage
        set_url '/calculation/disposable_capital'
        element :heading, :exact_heading_text, t('hwf_pages.disposable_capital.heading')
        section :disposable_capital, :calculator_question, t('hwf_pages.disposable_capital.questions.disposable_capital.label') do
          @i18n_scope = 'hwf_pages.disposable_capital.questions.disposable_capital'
          include ::Calculator::Test::DisposableCapitalQuestionSection
        end
        element :next_button, :button, t('hwf_pages.disposable_capital.buttons.next')

        def next
          next_button.click
        end

        # Toggles the guidance text for this question
        def toggle_guidance
          disposable_capital.toggle_guidance
        end

        # Validates that the guidance text is correct for the english language
        # @raise [Capybara::ExpectationNotMet] if the text wasn't found in the correct place
        def validate_guidance
          disposable_capital.validate_guidance
        end

        # Indicates if the disposable capital field has no guidance text visible
        def has_no_guidance?
          disposable_capital.has_no_guidance_text?
        end

        # Waits for the guidance to be visible
        # @raise [Capybara::ExpectationNotMet] if the guidance never became visible in the allowed timeout
        def wait_for_guidance
          disposable_capital.wait_for_guidance_text
        end
      end
    end
  end
end

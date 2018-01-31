module Calculator
  module Test
    module En
      class DisposableCapitalPage < BasePage
        set_url '/calculation/disposable_capital'
        element :heading, :exact_heading_text, 'Find out if you could get help with fees'
        section :disposable_capital, ::Calculator::Test::DisposableCapitalQuestionSection, :calculator_question, 'How much do you have in savings and investment combined?'
        element :next_button, :button, 'Next step'

        def next
          next_button.click
        end

        # Toggles the guidance text for this question
        def toggle_guidance
          disposable_capital.toggle_help
        end

        # Validates that the guidance text is correct for the english language
        # @raise [Capybara::ExpectationNotMet] if the text wasn't found in the correct place
        def validate_guidance
          disposable_capital.validate_guidance(messaging.t('hwf_pages.disposable_capital.guidance.disposable_capital.text'))
        end

        # Indicates if the marital status field has no guidance text visible
        def has_no_guidance?
          disposable_capital.has_no_help_text?
        end

        # Waits for the guidance to be visible
        # @raise [Capybara::ExpectationNotMet] if the guidance never became visible in the allowed timeout
        def wait_for_guidance
          disposable_capital.wait_for_help_text
        end

        # Find an error matching the given text in the disposable_capital field
        #
        # @param [String] text The error message to match
        #
        # @return [Capybara::Node::Element] The node found
        # @raise [Capybara::ElementNotFound] If an error message could not be found
        def error_with_text(text)
          disposable_capital.error_with_text(text)
        end

        delegate :has_error_with_text?, to: :disposable_capital
      end
    end
  end
end

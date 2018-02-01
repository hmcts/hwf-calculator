module Calculator
  module Test
    module En
      class TotalIncomePage < BasePage
        set_url '/calculation/total_income'
        element :heading, :exact_heading_text, t('hwf_pages.total_income.heading')
        section :total_income, :calculator_question, t('hwf_pages.total_income.questions.total_income.label') do
          @i18n_scope = 'hwf_pages.total_income.questions.total_income'
          include ::Calculator::Test::TotalIncomeQuestionSection
        end
        element :next_button, :button, t('hwf_pages.total_income.buttons.next')

        def next
          next_button.click
        end

        # Toggles the guidance text for this question
        def toggle_guidance
          total_income.toggle_help
        end

        # Validates that the guidance text is correct for the english language
        # @raise [Capybara::ExpectationNotMet] if the text wasn't found in the correct place
        def validate_guidance
          total_income.validate_guidance(messaging.t('hwf_pages.total_income.questions.total_income.guidance.text'))
        end

        # Indicates if the marital status field has no guidance text visible
        def has_no_guidance?
          total_income.has_no_help_text?
        end

        # Waits for the guidance to be visible
        # @raise [Capybara::ExpectationNotMet] if the guidance never became visible in the allowed timeout
        def wait_for_guidance
          total_income.wait_for_help_text
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

        delegate :has_error_with_text?, to: :total_income
      end
    end
  end
end

module Calculator
  module Test
    module En
      class NumberOfChildrenPage < BasePage
        set_url '/calculation/number_of_children'
        element :heading, :exact_heading_text, t('hwf_pages.number_of_children.heading')
        section :number_of_children, :calculator_question, t('hwf_pages.number_of_children.questions.number_of_children.label') do
          @i18n_scope = 'hwf_pages.number_of_children.questions.number_of_children'
          include ::Calculator::Test::NumberOfChildrenQuestionSection
        end
        element :next_button, :button, t('hwf_pages.number_of_children.buttons.next')

        # Progress to the next page
        def next
          next_button.click
        end

        # Toggles the guidance text for this question
        def toggle_guidance
          number_of_children.toggle_guidance
        end

        # Validates that the guidance text is correct for the english language
        # @raise [Capybara::ExpectationNotMet] if the text wasn't found in the correct place
        def validate_guidance
          number_of_children.validate_guidance
        end

        # Indicates if the number of children field has no guidance text visible
        def has_no_guidance?
          number_of_children.has_no_guidance_text?
        end

        # Waits for the guidance to be visible
        # @raise [Capybara::ExpectationNotMet] if the guidance never became visible in the allowed timeout
        def wait_for_guidance
          number_of_children.wait_for_guidance_text
        end
      end
    end
  end
end

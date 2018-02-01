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

        delegate :has_no_guidance_text?,
          :toggle_guidance,
          :validate_guidance,
          :wait_for_guidance_text,
          to: :number_of_children
      end
    end
  end
end

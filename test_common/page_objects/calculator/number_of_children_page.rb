module Calculator
  module Test
    class NumberOfChildrenPage < BasePage
      CHILDREN_SINGLE_LABEL = t('hwf_pages.number_of_children.questions.number_of_children.label.single')
      CHILDREN_MARRIED_LABEL = t('hwf_pages.number_of_children.questions.number_of_children.label.sharing_income')

      set_url t('hwf_urls.number_of_children')
      element :heading, :exact_heading_text, t('hwf_pages.number_of_children.heading')
      element :next_button, :button, t('hwf_pages.number_of_children.buttons.next')

      section :number_of_children, :calculator_question, [CHILDREN_SINGLE_LABEL, CHILDREN_MARRIED_LABEL], exact: true do
        @i18n_scope = 'hwf_pages.number_of_children.questions.number_of_children'
        include ::Calculator::Test::NumberOfChildrenQuestionSection
      end

      section :number_of_children_single, :calculator_question, CHILDREN_SINGLE_LABEL, exact: true do
        @i18n_scope = 'hwf_pages.number_of_children.questions.number_of_children'
        include ::Calculator::Test::NumberOfChildrenQuestionSection
      end

      section :number_of_children_married, :calculator_question, CHILDREN_MARRIED_LABEL, exact: true do
        @i18n_scope = 'hwf_pages.number_of_children.questions.number_of_children'
        include ::Calculator::Test::NumberOfChildrenQuestionSection
      end

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

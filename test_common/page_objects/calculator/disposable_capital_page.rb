module Calculator
  module Test
    class DisposableCapitalPage < BasePage
      QUESTION_SINGLE_LABEL = t('hwf_pages.disposable_capital.questions.disposable_capital.label.single')
      QUESTION_MARRIED_LABEL = t('hwf_pages.disposable_capital.questions.disposable_capital.label.sharing_income')

      set_url t('hwf_urls.disposable_capital')
      element :heading, :exact_heading_text, t('hwf_pages.disposable_capital.heading')
      element :next_button, :button, t('hwf_pages.disposable_capital.buttons.next')

      section :disposable_capital, :calculator_question, [QUESTION_SINGLE_LABEL, QUESTION_MARRIED_LABEL], exact: true do
        @i18n_scope = 'hwf_pages.disposable_capital.questions.disposable_capital'
        include ::Calculator::Test::DisposableCapitalQuestionSection
        element :hint, :hint_with_text, ["#{i18n_scope}.hint.single", "#{i18n_scope}.hint.sharing_income"]
      end

      section :disposable_capital_single, :calculator_question, QUESTION_SINGLE_LABEL, exact: true do
        @i18n_scope = 'hwf_pages.disposable_capital.questions.disposable_capital'
        include ::Calculator::Test::DisposableCapitalQuestionSection
        element :hint, :hint_with_text, :"#{i18n_scope}.hint.single"
      end

      section :disposable_capital_married, :calculator_question, QUESTION_MARRIED_LABEL, exact: true do
        @i18n_scope = 'hwf_pages.disposable_capital.questions.disposable_capital'
        include ::Calculator::Test::DisposableCapitalQuestionSection
        element :hint, :hint_with_text, :"#{i18n_scope}.hint.sharing_income"
      end

      def next
        next_button.click
      end

      delegate :has_no_guidance_text?,
        :toggle_guidance,
        :validate_guidance,
        :wait_for_guidance_text,
        to: :disposable_capital
    end
  end
end

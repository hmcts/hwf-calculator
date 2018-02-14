module Calculator
  module Test
    class TotalIncomePage < BasePage
      set_url t('hwf_urls.total_income')
      element :heading, :exact_heading_text, t('hwf_pages.total_income.heading')
      element :next_button, :button, t('hwf_pages.total_income.buttons.next')

      section :total_income, :calculator_question, t('hwf_pages.total_income.questions.total_income.label') do
        @i18n_scope = 'hwf_pages.total_income.questions.total_income'
        include ::Calculator::Test::TotalIncomeQuestionSection
      end

      def next
        next_button.click
      end

      delegate :has_no_guidance_text?,
        :toggle_guidance,
        :validate_guidance,
        :wait_for_guidance_text,
        to: :total_income
    end
  end
end

module Calculator
  module Test
    class DisposableCapitalPage < BasePage
      set_url t('hwf_urls.disposable_capital')
      element :heading, :exact_heading_text, t('hwf_pages.disposable_capital.heading')
      element :next_button, :button, t('hwf_pages.disposable_capital.buttons.next')

      section :disposable_capital, :calculator_question, t('hwf_pages.disposable_capital.questions.disposable_capital.label') do
        @i18n_scope = 'hwf_pages.disposable_capital.questions.disposable_capital'
        include ::Calculator::Test::DisposableCapitalQuestionSection
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

module Calculator
  module Test
    class DateOfBirthPage < BasePage
      set_url t('hwf_urls.date_of_birth')
      element :heading, :exact_heading_text, t('hwf_pages.date_of_birth.heading')
      element :next_button, :button, t('hwf_pages.date_of_birth.buttons.next')

      section :date_of_birth,  :calculator_question, t('hwf_pages.date_of_birth.questions.date_of_birth.label') do
        @i18n_scope = 'hwf_pages.date_of_birth.questions.date_of_birth'
        include ::Calculator::Test::DateOfBirthQuestionSection
      end

      section :partner_date_of_birth, :calculator_question, t('hwf_pages.date_of_birth.questions.partner_date_of_birth.label') do
        @i18n_scope = 'hwf_pages.date_of_birth.questions.partner_date_of_birth'
        include ::Calculator::Test::DateOfBirthQuestionSection
      end

      def next
        next_button.click
      end
    end
  end
end

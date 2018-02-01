module Calculator
  module Test
    module En
      class DateOfBirthPage < BasePage
        set_url '/calculation/date_of_birth'
        element :heading, :exact_heading_text, t('hwf_pages.date_of_birth.heading')
        section :date_of_birth, ::Calculator::Test::DateOfBirthQuestionSection, :calculator_question, t('hwf_pages.date_of_birth.questions.date_of_birth.label')
        section :partner_date_of_birth, ::Calculator::Test::DateOfBirthQuestionSection, :calculator_question, t('hwf_pages.date_of_birth.questions.partner_date_of_birth.label')
        element :next_button, :button, t('hwf_pages.date_of_birth.buttons.next')

        def next
          next_button.click
        end
      end
    end
  end
end

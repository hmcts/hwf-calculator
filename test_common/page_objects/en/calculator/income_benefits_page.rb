module Calculator
  module Test
    module En
      class IncomeBenefitsPage < BasePage
        section :benefits, ::Calculator::Test::QuestionCheckboxListSection, :calculator_question, 'Select all income benefits you are currently receiving'
        element :next_button, :button, 'Next step'

        def next
          next_button.click
        end

        def choose_none
          label_text = messaging.t('hwf_pages.income_benefits.labels.benefits.none')
          raise 'Not yet implemented'
        end

        def choose_dont_know
          label_text = messaging.t('hwf_pages.income_benefits.labels.benefits.dont_know')
          benefits.set([label_text])
        end


      end
    end
  end
end

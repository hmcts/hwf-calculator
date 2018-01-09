module Calculator
  module Test
    module En
      class TotalIncomePage < BasePage
        set_url '/calculation/total_income'
        section :total_income, ::Calculator::Test::QuestionNumericSection, :calculator_question, 'How much total income do you receive each month?'
        element :next_button, :button, 'Next step'

        def next
          next_button.click
        end

        def error_with_text(text)
          total_income.error_with_text(text)
        end
      end
    end
  end
end

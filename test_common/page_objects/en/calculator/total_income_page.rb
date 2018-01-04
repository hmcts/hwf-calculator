module Calculator
  module Test
    module En
      class TotalIncomePage < BasePage
        section :total_income, ::Calculator::Test::QuestionNumericSection, :calculator_question, 'How much total income do you receive each month?'
        element :next_button, :button, 'Next step'

        def next
          next_button.click
        end
      end
    end
  end
end

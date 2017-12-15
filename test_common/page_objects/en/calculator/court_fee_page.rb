module Calculator
  module Test
    module En
      class CourtFeePage < BasePage
        section :fee, ::Calculator::Test::QuestionNumericSection, :calculator_question, 'How much is the court or tribunal fee you have to pay (or have paid within the last 3 months)?'
        element :next_button, :button, 'Next step'

        def next
          next_button.click
        end
      end
    end
  end
end

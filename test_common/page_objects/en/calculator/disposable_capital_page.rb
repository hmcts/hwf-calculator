module Calculator
  module Test
    module En
      class DisposableCapitalPage < BasePage
        section :disposable_capital, ::Calculator::Test::QuestionNumericSection, :calculator_question, 'How much do you have in savings and investment combined?'
        element :next_button, :button, 'Next step'

        def next
          next_button.click
        end
      end
    end
  end
end

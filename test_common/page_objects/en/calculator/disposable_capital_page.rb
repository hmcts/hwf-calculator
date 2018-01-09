module Calculator
  module Test
    module En
      class DisposableCapitalPage < BasePage
        set_url '/calculation/disposable_capital'
        section :disposable_capital, ::Calculator::Test::QuestionNumericSection, :calculator_question, 'How much do you have in savings and investment combined?'
        element :next_button, :button, 'Next step'

        def next
          next_button.click
        end

        def error_with_text(text)
          disposable_capital.error_with_text(text)
        end
      end
    end
  end
end

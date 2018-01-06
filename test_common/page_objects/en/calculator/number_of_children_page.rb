module Calculator
  module Test
    module En
      class NumberOfChildrenPage < BasePage
        set_url '/calculation/number_of_children'
        section :number_of_children, ::Calculator::Test::QuestionNumericSection, :calculator_question, 'How many children live with you or are you responsible for supporting financially?'
        element :next_button, :button, 'Next step'

        def next
          next_button.click
        end
      end
    end
  end
end

module CalculatorFrontEnd
  module Test
    module En
      class MaritalStatusPage < BasePage
        section :marital_status, ::CalculatorFrontEnd::Test::QuestionRadioListSection, :calculator_question, 'Are you single, married or living with someone and sharing an income?'
        element :next_button, :button, 'Next step'

        def next
          next_button.click
        end
      end
    end
  end
end

module CalculatorFrontEnd
  module Test
    module En
      class DateOfBirthPage < BasePage
        section :date_of_birth, ::CalculatorFrontEnd::Test::QuestionDateSection, :calculator_question, 'What is your date of birth?'
        element :next_button, :button, 'Next step'

        def next
          next_button.click
        end
      end
    end
  end
end

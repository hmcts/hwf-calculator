module Calculator
  module Test
    module En
      class DateOfBirthPage < BasePage
        set_url '/calculation/date_of_birth'
        section :date_of_birth, ::Calculator::Test::QuestionDateSection, :calculator_question, 'What is your date of birth?'
        section :partner_date_of_birth, ::Calculator::Test::QuestionDateSection, :calculator_question, 'What is your partners date of birth?'
        element :next_button, :button, 'Next step'

        def next
          next_button.click
        end
      end
    end
  end
end

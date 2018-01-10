module Calculator
  module Test
    module En
      class MaritalStatusPage < BasePage
        set_url '/calculation/marital_status'
        section :marital_status, ::Calculator::Test::QuestionRadioListSection, :calculator_question, 'Are you single, married or living with someone and sharing an income?'
        element :next_button, :button, 'Next step'

        # Progress to the next page
        def next
          next_button.click
        end
      end
    end
  end
end

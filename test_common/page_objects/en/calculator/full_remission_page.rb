module Calculator
  module Test
    module En
      class FullRemissionPage < BasePage
        set_url '/calculation/full_remission_available'

        section :positive, '.positive' do
          element :calculator_feedback_header, 'calculator_feedback_header', text: 'You are able to get help with fees'
        end
        element :previous_question, '.previous_questions', text: 'Income benefits you are currently receivingIS'
      end
    end
  end
end

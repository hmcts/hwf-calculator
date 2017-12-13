require_relative '../../../sections'
module CalculatorFrontEnd
  module Test
    module En
      class BasePage < ::SitePrism::Page
        section :feedback, ::CalculatorFrontEnd::Test::FeedbackSection, '[data-behavior=calculator_feedback]'
        section :previous_answers, '[data-behavior=calculator_previous_questions]' do |_s|
          section :total_savings, ::CalculatorFrontEnd::Test::PreviousQuestionSection, :calculator_previous_question, "How much do you have in savings and investment combined?"
        end

        def load_page
          load
        end

        def positive_feedback_message_saying(msg)
          feedback.positive_message_saying(msg)
        end
      end
    end
  end
end

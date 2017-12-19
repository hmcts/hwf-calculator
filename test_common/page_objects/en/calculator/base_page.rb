require_relative '../../../sections'
module Calculator
  module Test
    module En
      class BasePage < ::SitePrism::Page
        section :feedback, ::Calculator::Test::FeedbackSection, '[data-behavior=calculator_feedback]'
        section :previous_answers, '[data-behavior=calculator_previous_questions]' do |_s|
          section :disposable_capital, ::Calculator::Test::PreviousQuestionSection, :calculator_previous_question, "How much do you have in savings and investment combined?"
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

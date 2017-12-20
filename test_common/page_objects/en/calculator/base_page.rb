require_relative '../../../sections'
module Calculator
  module Test
    module En
      class BasePage < ::SitePrism::Page
        section :feedback, ::Calculator::Test::FeedbackSection, '[data-behavior=calculator_feedback]'
        section :previous_answers, '[data-behavior=calculator_previous_questions]' do |_s|
          section :disposable_capital, ::Calculator::Test::PreviousQuestionSection, :calculator_previous_question, "How much do you have in savings and investment combined?"
        end

        def messaging
          @messaging ||= ::Calculator::Test::Messaging.new
        end

        def load_page
          load
        end

        def feedback_message_with_detail(msg)
          feedback.message_with_detail(msg)
        end

        def feedback_message_with_header(header)
          feedback.message_with_header(header)
        end

        def positive_message
          feedback.positive_message
        end

        def negative_message
          feedback.negative_message
        end
      end
    end
  end
end

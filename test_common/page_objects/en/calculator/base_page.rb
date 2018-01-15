require_relative '../../../sections'
module Calculator
  module Test
    module En
      class BasePage < ::SitePrism::Page
        ALL_QUESTIONS = [:marital_status, :court_fee, :disposable_capital, :income_benefits].freeze

        section :feedback, ::Calculator::Test::FeedbackSection, '[data-behavior=calculator_feedback]'
        section :previous_answers, '[data-behavior=calculator_previous_questions]' do |_s|
          section :marital_status, ::Calculator::Test::PreviousQuestionSection, :calculator_previous_question, "What is your status"
          section :court_fee, ::Calculator::Test::PreviousQuestionSection, :calculator_previous_question, "Court or tribunal fee to pay"
          section :disposable_capital, ::Calculator::Test::PreviousQuestionSection, :calculator_previous_question, "Combined savings and investment"
          section :income_benefits, ::Calculator::Test::PreviousQuestionSection, :calculator_previous_question, "Income benefits you are currently receiving"

          def disabled?
            ALL_QUESTIONS.all? {|q| send(q).disabled?}
          end
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

        def go_back_to_question(q)
          previous_answers.send(q.to_sym).navigate_to
        end
      end
    end
  end
end

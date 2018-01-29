module Calculator
  module Test
    class FeedbackSection < BaseSection
      def message_with_detail(msg)
        within @root_element do
          find '[data-behavior=calculator_feedback_message]', text: msg
        end
      end

      def message_with_header(header)
        within @root_element do
          find '[data-behavior=calculator_feedback_header]', text: header
        end
      end

      def positive_message
        within @root_element do
          find '.positive'
        end
      end

      def negative_message
        within @root_element do
          find '.negative'
        end
      end
    end
  end
end

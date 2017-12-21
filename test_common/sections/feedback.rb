module Calculator
  module Test
    class FeedbackSection < BaseSection
      def message_with_detail(msg)
        find '[data-behavior=calculator_feedback_message]', text: msg
      end

      def message_with_header(header)
        find '[data-behavior=calculator_feedback_header]', text: header
      end

      def positive_message
        find '.positive'
      end

      def negative_message
        find '.negative'
      end
    end
  end
end

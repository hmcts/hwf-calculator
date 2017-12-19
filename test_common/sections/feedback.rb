module Calculator
  module Test
    class FeedbackSection < ::SitePrism::Section
      def message_saying(msg)
        find '[data-behavior=calculator_feedback_message]', text: msg
      end

      def positive_message
        find '.positive[data-behavior=calculator_feedback_message]'
      end

      def negative_message
        find '.negative[data-behavior=calculator_feedback_message]'
      end
    end
  end
end

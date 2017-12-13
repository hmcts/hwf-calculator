module CalculatorFrontEnd
  module Test
    class FeedbackSection < ::SitePrism::Section
      def positive_message_saying(msg)
        find '[data-behavior=calculator_feedback_message]', text: msg
      end
    end
  end
end

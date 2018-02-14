module Calculator
  module Test
    module FeedbackSection
      extend ActiveSupport::Concern
      include BaseSection

      included do
        elements :messages, '[data-behavior=calculator_feedback_header],[data-behavior=calculator_feedback_message]'
        element :positive_message, '.positive'
        element :negative_message, '.negative'
      end

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
    end
  end
end

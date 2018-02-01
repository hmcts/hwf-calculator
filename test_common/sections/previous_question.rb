module Calculator
  module Test
    module PreviousQuestionSection
      extend ActiveSupport::Concern
      include BaseSection

      included do
        element :answer, '[data-behavior=answer]'
        element :link, '[data-behavior=action] a[href]', text: "Change"
      end

      def navigate_to
        link.click
      end

      def disabled?
        has_no_link?
      end
    end
  end
end

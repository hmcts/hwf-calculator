module Calculator
  module Test
    class PreviousQuestionSection < BaseSection
      element :answer, '[data-behavior=answer]'
      element :link, '[data-behavior=action] a[href]', text: "Change"

      def navigate_to
        link.click
      end

      def disabled?
        has_no_link?
      end
    end
  end
end

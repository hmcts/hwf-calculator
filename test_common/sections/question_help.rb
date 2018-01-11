module Calculator
  module Test
    class QuestionHelpSection < BaseSection
      element :toggle_node, '[data-behavior=toggle]'
      element :help_text, '[data-behavior=question_help_text]'
      def toggle
        toggle_node.click
      end
    end
  end
end
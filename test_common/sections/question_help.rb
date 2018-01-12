module Calculator
  module Test
    class QuestionHelpSection < BaseSection
      element :toggle_node, '[data-behavior=toggle]'
      element :help_text, '[data-behavior=question_help_text]'
      element :expanded_root, :xpath, (XPath.generate { |x| x.self[x.attr(:open)] })
      element :collapsed_root, :xpath, './self::*[not(@open)]'

      # Toggles help text
      def toggle
        toggle_node.click
      end

      # Indicates if the help text is collapsed, if not waits for it.  If it
      # has not collapsed by the standard timeout, returns false
      #
      # @return [Boolean] Indicates if collapsed
      def help_text_collapsed?
        has_collapsed_root?
      end

      # Indicates if the help text is expanded, if not waits for it.  If it
      # has not expanded by the standard timeout, returns false
      #
      # @return [Boolean] Indicates if collapsed
      def help_text_expanded?
        has_expanded_root?
      end
    end
  end
end

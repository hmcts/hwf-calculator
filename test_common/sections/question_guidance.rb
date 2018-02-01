module Calculator
  module Test
    module QuestionGuidanceSection
      extend ActiveSupport::Concern
      include BaseSection

      included do
        element :toggle_node, '[data-behavior=toggle]'
        element :guidance_text, '[data-behavior=question_help_text]'
        element :expanded_root, :xpath, (XPath.generate { |x| x.self[x.attr(:open)] })
        element :collapsed_root, :xpath, './self::*[not(@open)]'
      end

      # Toggles guidance text
      def toggle
        toggle_node.click
      end

      # Indicates if the guidance text is collapsed, if not waits for it.  If it
      # has not collapsed by the standard timeout, returns false
      #
      # @return [Boolean] Indicates if collapsed
      def guidance_text_collapsed?
        has_collapsed_root?
      end

      # Indicates if the guidance text is expanded, if not waits for it.  If it
      # has not expanded by the standard timeout, returns false
      #
      # @return [Boolean] Indicates if collapsed
      def guidance_text_expanded?
        has_expanded_root?
      end
    end
  end
end

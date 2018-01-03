require_relative './question_section'
module Calculator
  module Test
    class QuestionCheckboxListSection < QuestionSection
      element :label, 'legend'
      sections :options, GdsMultipleChoiceOptionSection, :gds_multiple_choice_option
      # @param [Array<String>] values An array of checkboxes to select by value
      def set(values)
        values.each do |value|
          check value
        end
      end

      def option_labelled(text)
        node = find :gds_multiple_choice_option, text: text
        GdsMultipleChoiceOptionSection.new self, node
      end
    end
  end
end

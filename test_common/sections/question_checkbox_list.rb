module Calculator
  module Test
    class QuestionCheckboxListSection < BaseSection
      element :label, 'legend'
      sections :options, GdsMultipleChoiceOptionSection, :gds_multiple_choice_option
      # @param [Array<String>] values An array of checkboxes to select by value
      def set(values)
        values.each do |value|
          check value
        end
      end

      def option_labelled(text)
        find :gds_multiple_choice_option, text: text
      end
    end
  end
end

require_relative './question_section'
require_relative './gds_multiple_choice_option'
module Calculator
  module Test
    class QuestionCheckboxListSection < QuestionSection
      element :label, 'legend'
      sections :options, GdsMultipleChoiceOptionSection, :gds_multiple_choice_option
      # @param [Array<String>] values An array of checkboxes to select by value
      def set(values)
        within @root_element do
          values.each do |value|
            check value
          end
        end
      end

      def option_labelled(text)
        within @root_element do
          node = find :gds_multiple_choice_option, text: text
          GdsMultipleChoiceOptionSection.new self, node
        end
      end
      # rubocop:disable Style/PredicateName

      # Validates that the values provided are selected in the checkbox list
      # and that other values are not.
      # note that this uses has_selector which means it will wait for the value
      # to arrive, subject to timeout of course.
      # @param [Array<String>] values The values to validate are selected
      # @return [Boolean] true if they are selected, else false
      def has_value?(values)
        SitePrism::Waiter.wait_until_true do
          checked_options = options.select(&:checked?).map(&:text)
          values.sort == checked_options.sort
        end
      rescue SitePrism::TimeoutException
        false
      end

      # rubocop:enable Style/PredicateName
    end
  end
end

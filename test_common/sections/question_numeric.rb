require_relative 'question_section'

module Calculator
  module Test
    module QuestionNumericSection
      extend ActiveSupport::Concern
      include QuestionSection
      included do
        element :field, :field
        delegate :set, to: :field
      end

      # rubocop:disable Style/PredicateName

      # Validates that the value provided is present in the input control
      # note that this uses has_selector which means it will wait for the value
      # to arrive, subject to timeout of course.
      # @param [String] value The value to validate is present
      # @return [Boolean] true if it is present, else false
      def has_value?(value)
        field(with: value)
      end
      # rubocop:enable Style/PredicateName
    end
  end
end

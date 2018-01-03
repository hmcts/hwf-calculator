module Calculator
  module Test
    class QuestionNumericSection < BaseSection
      element :field, 'input'
      delegate :set, to: :field
    end
  end
end

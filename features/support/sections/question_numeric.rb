module CalculatorFrontEnd
  module Test
    class QuestionNumericSection < ::SitePrism::Section
      element :field, 'input'
      delegate :set, to: :field
    end
  end
end

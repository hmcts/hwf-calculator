module CalculatorFrontEnd
  module Test
    class QuestionRadioListSection < ::SitePrism::Section
      def set(value)
        choose(value)
      end
    end
  end
end

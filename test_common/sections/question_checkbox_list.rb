module Calculator
  module Test
    class QuestionCheckboxListSection < ::SitePrism::Section
      element :label, 'legend'

      # @param [Array<String>] values An array of checkboxes to select by value
      def set(values)
        values.each do |value|
          check value
        end
      end
    end
  end
end

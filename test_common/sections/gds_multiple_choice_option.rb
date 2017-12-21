module Calculator
  module Test
    class GdsMultipleChoiceOptionSection < BaseSection
      element :checkbox, 'input[type=checkbox]'
      def disabled?
        checkbox.disabled?
      end

      def guidance_id
        @root_element['data-target']
      end
    end
  end
end
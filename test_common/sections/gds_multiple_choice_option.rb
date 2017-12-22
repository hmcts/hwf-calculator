module Calculator
  module Test
    class GdsMultipleChoiceOptionSection < BaseSection
      element :checkbox, 'input[type=checkbox]'
      delegate :disabled?, to: :checkbox

      def guidance_id
        @root_element['data-target']
      end
    end
  end
end

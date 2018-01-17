module Calculator
  module Test
    class GdsMultipleChoiceOptionSection < BaseSection
      element :checkbox, 'input[type=checkbox]'
      element :guidance, '[data-behavior=multiple_choice_guidance]'
      delegate :disabled?, to: :checkbox

      def guidance_with_text(text)
        guidance(text: text)
      end
    end
  end
end

module Calculator
  module Test
    # Represents a correctly wrapped checkbox for GDS multiple choice answers
    class GdsMultipleChoiceOptionSection < BaseSection
      element :checkbox, 'input[type=checkbox]'
      element :label, 'label'
      element :guidance, '[data-behavior=multiple_choice_guidance]'
      delegate :disabled?, to: :checkbox

      def guidance_with_text(text)
        guidance(text: text)
      end

      def unselected?
        SitePrism::Waiter.wait_until_true do
          !checked?
        end
      rescue SitePrism::TimeoutException
        false
      end

      delegate :checked?, to: :checkbox
      delegate :text, to: :label
    end
  end
end

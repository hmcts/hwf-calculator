module Calculator
  module Test
    # Represents a correctly wrapped checkbox for GDS multiple choice answers
    module GdsMultipleChoiceOptionSection
      extend ActiveSupport::Concern
      include BaseSection

      included do
        element :checkbox, 'input[type=checkbox]'
        element :label, 'label'
        element :guidance, '[data-behavior=multiple_choice_guidance]'
        delegate :disabled?, to: :checkbox
        delegate :checked?, to: :checkbox
        delegate :text, to: :label
      end

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
    end
  end
end

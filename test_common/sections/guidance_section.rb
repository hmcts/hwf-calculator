module Calculator
  module Test
    module GuidanceSection
      extend ActiveSupport::Concern
      included do
        section :guidance_section, :guidance_section_labelled, t("#{i18n_scope}.guidance.label") do
          include QuestionGuidanceSection
        end

        delegate :wait_for_guidance_text, to: :guidance_section
        delegate :wait_for_no_guidance_text, to: :guidance_section
      end

      # Validates that the guidance text is as expected
      # @raise [Capybara::ExpectationNotMet] if the assertion hasn't succeeded during wait time
      def validate_guidance
        strings = Array(messaging.t("#{i18n_scope}.guidance.text"))
        guidance_section.assert_text(strings.join("\n"))
      end

      def toggle_guidance
        guidance_section.toggle
      end

      def has_no_guidance_text?
        guidance_section.guidance_text_collapsed?
      end
    end
  end
end
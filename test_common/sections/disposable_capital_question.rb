require_relative 'question_numeric'
require_relative 'question_help'
module Calculator
  module Test
    module DisposableCapitalQuestionSection
      extend ActiveSupport::Concern
      include QuestionNumericSection

      included do
        section :help_section, :help_section_labelled, t("#{i18n_scope}.guidance.label") do
          include QuestionHelpSection
        end

        element :hint, '.form-hint', text: t("#{i18n_scope}.hint")
        element :error_non_numeric, :exact_error_text, t("#{i18n_scope}.errors.non_numeric")
        element :error_blank, :exact_error_text, t("#{i18n_scope}.errors.blank")

        delegate :wait_for_help_text, to: :help_section
        delegate :wait_for_no_help_text, to: :help_section
      end

      # Validates that the guidance text is as expected
      # @raise [Capybara::ExpectationNotMet] if the assertion hasn't succeeded during wait time
      def validate_guidance
        strings = Array(messaging.t("#{i18n_scope}.guidance.text"))
        help_section.assert_text(strings.join("\n"))
      end

      def toggle_help
        help_section.toggle
      end

      # rubocop:disable Style/PredicateName
      def has_no_help_text?
        help_section.help_text_collapsed?
      end

      def has_help_text?
        help_section.help_text_expanded?
      end
    end
  end
end

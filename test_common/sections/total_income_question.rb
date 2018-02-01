require_relative 'question_numeric'
module Calculator
  module Test
    module TotalIncomeQuestionSection
      extend ActiveSupport::Concern
      include QuestionNumericSection

      included do
        section :help_section, :help_section_labelled, t("#{i18n_scope}.guidance.label") do
          include QuestionHelpSection
        end

        delegate :wait_for_help_text, to: :help_section
        delegate :wait_for_no_help_text, to: :help_section
      end

      # Validates that the guidance text is as expected
      # @param [String, Array[String]] text_or_array Either a single string to (partially) match or an
      #  array of strings which will be joined by a CR.  Note that whitespace should not be important,
      # nor html structure etc..
      # @raise [Capybara::ExpectationNotMet] if the assertion hasn't succeeded during wait time
      def validate_guidance(text_or_array)
        strings = Array(text_or_array)
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

      def has_error_with_text?(text)
        translated = case text
                     when Symbol then messaging.t("#{i18n_scope}.errors.#{text}")
                     else text
                     end
        error_with_text(translated)
      rescue Capybara::ElementNotFound
        false
      end

      def has_hint?
        hint_with_text(messaging.t("#{i18n_scope}.hint"))
        true
      rescue Capybara::ElementNotFound
        false
      end
      # rubocop:enable Style/PredicateName

    end
  end
end

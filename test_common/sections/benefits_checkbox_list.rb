require_relative './question_checkbox_list'
require_relative 'question_help'
module Calculator
  module Test
    class BenefitsCheckboxListSection < QuestionCheckboxListSection
      section :help_section, QuestionHelpSection, :help_section_labelled, 'How benefit affects your claim'

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
      # rubocop:enable Style/PredicateName

      delegate :wait_for_help_text, to: :help_section

      delegate :wait_for_no_help_text, to: :help_section

      def dont_know_guidance
        option = option_labelled(messaging.t('hwf_pages.income_benefits.labels.benefits.dont_know'))
        option.guidance_with_text(messaging.t('hwf_pages.income_benefits.guidance.dont_know_option'))
      end

      def none_of_the_above_guidance
        option = option_labelled(messaging.t('hwf_pages.income_benefits.labels.benefits.none'))
        option.guidance_with_text(messaging.t('hwf_pages.income_benefits.guidance.none_option'))
      end
    end
  end
end

require_relative 'question_radio_list'
require_relative 'question_help'
module Calculator
  module Test
    class MaritalStatusQuestionSection < QuestionRadioListSection
      section :help_section, QuestionHelpSection, :help_section_labelled, 'Help with Status'

      # Validates that the guidance text is as expected
      # @param [String, Array[String]] text_or_array Either a single string to (partially) match or an array of strings which
      #   will be joined by a CR.  Note that whitespace should not be important, nor html structure etc..
      # @raise [Capybara::ExpectationNotMet] if the assertion hasn't succeeded during wait time
      def validate_guidance(text_or_array)
        strings = Array(text_or_array)
        help_section.assert_text(strings.join("\n"))
      end

      def toggle_help
        help_section.toggle
      end

      def has_no_help_text?
        help_section.has_no_help_text?
      end

      def wait_for_help_text
        help_section.wait_for_help_text
      end

      def wait_until_help_text_invisible
        help_section.wait_until_help_text_invisible
      end
    end
  end
end
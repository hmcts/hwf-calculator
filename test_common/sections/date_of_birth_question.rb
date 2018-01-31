require_relative 'question_date'
module Calculator
  module Test
    class DateOfBirthQuestionSection < QuestionDateSection

      # Indicates iof the question is marked with the specified error message (or translation key)
      # @param [String,Symbol] text The error text to find or a translation key for it
      #   scoped to 'hwf_components.date_of_birth.errors'
      # @return [Boolean] True if the error message was found else false
      def has_error_with_text?(text)
        translated = case text
                     when Symbol then messaging.t("hwf_components.date_of_birth.errors.#{text}")
                     else text
                     end
        error_with_text(translated)
      rescue Capybara::ElementNotFound
        false
      end
    end
  end
end

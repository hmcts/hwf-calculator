require_relative 'question_date'
module Calculator
  module Test
    module DateOfBirthQuestionSection
      extend ActiveSupport::Concern
      include QuestionDateSection

      # Indicates iof the question is marked with the specified error message (or translation key)
      # @param [String,Symbol] text The error text to find or a translation key for it
      #   scoped to '<i18n_scope>.errors'
      # @return [Boolean] True if the error message was found else false
      def has_error_with_text?(text)
        translated = case text
                     when Symbol then messaging.t("#{i18n_scope}.errors.#{text}")
                     else text
                     end
        error_with_text(translated)
      rescue Capybara::ElementNotFound
        false
      end

      def has_hint_with_text?(key)
        hint_with_text(messaging.t("#{i18n_scope}.hint.#{key}"))
        true
      rescue Capybara::ElementNotFound
        false
      end
    end
  end
end

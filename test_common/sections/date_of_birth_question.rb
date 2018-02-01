require_relative 'question_date'
module Calculator
  module Test
    module DateOfBirthQuestionSection
      extend ActiveSupport::Concern
      include QuestionDateSection

      included do
        element :error_non_numeric, :exact_error_text, t("#{i18n_scope}.errors.non_numeric")
        element :error_under_age, :exact_error_text, t("#{i18n_scope}.errors.under_age")
      end
    end
  end
end

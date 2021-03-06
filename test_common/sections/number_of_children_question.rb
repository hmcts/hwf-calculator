require_relative 'question_numeric'
require_relative 'guidance_section'

module Calculator
  module Test
    module NumberOfChildrenQuestionSection
      extend ActiveSupport::Concern
      include QuestionNumericSection
      include GuidanceSection

      included do
        element :error_non_numeric, :exact_error_text, t("#{i18n_scope}.errors.non_numeric")
        element :error_too_high, :exact_error_text, t("#{i18n_scope}.errors.too_high")
        element :error_too_low, :exact_error_text, t("#{i18n_scope}.errors.too_low")
        element :error_blank, :exact_error_text, t("#{i18n_scope}.errors.blank")
      end
    end
  end
end

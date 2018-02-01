require_relative 'question_numeric'
require_relative 'question_guidance'
require_relative 'guidance_section'
module Calculator
  module Test
    # A section representing the court fee question
    module CourtFeeQuestionSection
      extend ActiveSupport::Concern
      include QuestionNumericSection
      include GuidanceSection

      included do
        element :hint, '.form-hint', text: t("#{i18n_scope}.hint")
        element :error_non_numeric, :exact_error_text, t("#{i18n_scope}.errors.non_numeric")
      end
    end
  end
end

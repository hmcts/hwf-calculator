require_relative 'question_numeric'
require_relative 'guidance_section'
require_relative 'hint_section'
module Calculator
  module Test
    module TotalIncomeQuestionSection
      extend ActiveSupport::Concern
      include QuestionNumericSection
      include GuidanceSection
      include HintSection

      included do
        element :error_non_numeric, :exact_error_text, t("#{i18n_scope}.errors.non_numeric")
        scope = i18n_scope
        section :guidance_section, :guidance_section_labelled, t("#{i18n_scope}.guidance.label") do
          @i18n_scope = scope
          include QuestionGuidanceSection
          element :what_to_include_exclude, :link, t("#{i18n_scope}.guidance.what_to_include_exclude.label")
        end

        delegate :wait_for_guidance_text, to: :guidance_section
        delegate :wait_for_no_guidance_text, to: :guidance_section

      end
    end
  end
end

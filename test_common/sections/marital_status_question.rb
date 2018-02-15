require_relative 'question_radio_list'
require_relative 'question_guidance'
require_relative 'guidance_section'
module Calculator
  module Test
    module MaritalStatusQuestionSection
      extend ActiveSupport::Concern
      include QuestionRadioListSection
      include GuidanceSection

      included do
        element :error_blank, :exact_error_text, t("#{i18n_scope}.errors.blank")
      end

      def set(value)
        super(translated_value value)
      end

      def has_value?(value)
        super(translated_value value)
      end

      private

      def translated_value(value)
        case value
        when String then
          value
        when Symbol then
          messaging.t("#{i18n_scope}.options.#{value}")
        end
      end
    end
  end
end

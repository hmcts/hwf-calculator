require_relative './question_checkbox_list'
require_relative 'question_guidance'
require_relative 'guidance_section'
module Calculator
  module Test
    module BenefitsCheckboxListSection
      extend ActiveSupport::Concern

      include QuestionCheckboxListSection
      include GuidanceSection

      included do
        element :error_nothing_selected, :exact_error_text, t("#{i18n_scope}.errors.nothing_selected")
      end

      def dont_know_guidance
        option = option_labelled(messaging.t("#{i18n_scope}.options.dont_know.label"))
        option.guidance_with_text(messaging.t("#{i18n_scope}.options.dont_know.guidance"))
      end

      def none_of_the_above_guidance
        option = option_labelled(messaging.t("#{i18n_scope}.options.none.label"))
        option.guidance_with_text(messaging.t("#{i18n_scope}.options.none.guidance"))
      end

      # Selects single or multiple items by label.  The labels are specified by I18n key so the
      # test suite can be multi lingual
      # @param [Symbol] keys Single or multiple keys into "<i18n_scope>.options"
      #   in the messaging/en.yml file.  Can be one of :dont_know, :none, :jobseekers_allowance,
      #   :employment_support_allowance, :income_support, :universal_credit, :pension_credit,
      #   :scottish_legal_aid
      def set(*keys)
        labels = keys.flatten.map do |key|
          if key.is_a?(Symbol)
            messaging.t("#{i18n_scope}.options.#{key}.label")
          else
            key
          end
        end
        super(labels)
      end

      # Indicates if the page has only the values specified options selected - waits for them if not then returns
      # false if it never arrives
      # @return [Boolean] Indicates if the page has only the specified options selected
      # @param [Array[String|Symbol]] values An array of strings or symbols.  If symbols, then the values are
      #   translated using <i18n_scope>.options.#{key}.label in the messaging/en.yml file.
      #   Can also be multiple values not in an array.
      def has_value?(*values)
        v = values.flatten.map do |value|
          if value.is_a?(Symbol)
            messaging.t("#{i18n_scope}.options.#{value}.label")
          else
            value
          end
        end
        super(v)
      end
    end
  end
end

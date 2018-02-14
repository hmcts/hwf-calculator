require_relative 'question_section'
module Calculator
  module Test
    module QuestionDateSection
      extend ActiveSupport::Concern
      include QuestionSection
      included do
        element :day, :field, t("#{i18n_scope}.components.day.label")
        element :month, :field, t("#{i18n_scope}.components.month.label")
        element :year, :field, t("#{i18n_scope}.components.year.label")
      end

      # Fills in the date fields
      # @param [String] value A string representing the date in the format 'd/m/Y'
      def set(value)
        day_part, month_part, year_part = value.split('/')
        day.set(day_part)
        month.set(month_part)
        year.set(year_part)
      end
    end
  end
end

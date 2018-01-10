module Calculator
  module Test
    class QuestionDateSection < QuestionSection
      element :day, :field, 'Day'
      element :month, :field, 'Month'
      element :year, :field, 'Year'

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

# Calculates a person's age given their birthday
# relative to midnight today unless another relative
# date is specified in the from: parameter
class AgeService

  # @param [Date] date_of_birth The person's date of birth
  # @param [Date] from The date to calculate from (defaults to today)
  # @return [Integer] The person's age in years
  def self.call(date_of_birth:, from: Time.zone.today)
    if before_this_years_birthday?(date_of_birth: date_of_birth, from: from)
      from.year - date_of_birth.year - 1
    else
      from.year - date_of_birth.year
    end
  end

  # @private
  def self.before_this_years_birthday?(date_of_birth:, from:)
    from.month < date_of_birth.month || (from.month == date_of_birth.month && from.day < date_of_birth.day)
  end

  private_class_method :before_this_years_birthday?
end
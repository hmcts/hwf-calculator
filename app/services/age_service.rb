# Calculates a person's age given their birthday
# relative to midnight today unless another relative
# date is specified in the from: parameter
class AgeService
  def self.call(date_of_birth:, from: Time.zone.today)
    if from.month < date_of_birth.month || (from.month == date_of_birth.month && from.day < date_of_birth.day)
      from.year - date_of_birth.year - 1
    else
      from.year - date_of_birth.year
    end
  end
end
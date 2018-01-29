# As our form objects convert to the correct type on input, rather than use the typical
# mess of fetching values before validation that active record does, we will take the
# approach of having an invalid date which is simply an instance of Date whose valid?
# method returns false and the day, month and year values are whatever is provided
class InvalidDate < Date
  attr_reader :day, :month, :year
  def self.new(year, month, day)
    super(1970, 1, 1).tap do |instance|
      instance.send(:initialize, year, month, day)
    end
  end

  def initialize(year, month, day)
    self.day = day
    self.month = month
    self.year = year
  end

  def blank?
    false
  end

  def valid?
    false
  end

  private

  attr_writer :day, :month, :year
end

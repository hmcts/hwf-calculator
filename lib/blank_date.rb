# As our form objects convert to the correct type on input, rather than use the typical
# mess of fetching values before validation that active record does, we will take the
# approach of having a blank date which is simply an instance of Date whose blank?
# method returns true
class BlankDate < Date
  def blank?
    true
  end

  def day
    nil
  end

  def month
    nil
  end

  def year
    nil
  end
end

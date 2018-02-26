class Field
  attr_reader :key, :value, :invalidated
  def initialize(key, value)
    self.key = key
    self.value = value
  end

  def invalidate
    self.invalidated = true
  end

  def confirm
    self.invalidated = false
  end

  private

  attr_writer :key, :value, :invalidated
end

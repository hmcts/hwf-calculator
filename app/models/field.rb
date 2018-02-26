class Field
  attr_reader :key, :value
  def initialize(key, value)
    self.key = key
    self.value = value
  end

  private

  attr_writer :key, :value
end
class FieldCollection
  def initialize(initial_fields = {})
    self.fields = initial_fields.inject({}) do |acc, (key, value)|
      acc[key] = value_for(key, value)
      acc
    end
  end

  def [](key)
    if key?(key)
      fields[key].value
    else
      UndefinedField.new
    end
  end

  def []=(key, value)
    fields[key] = Field.new(key, value) unless key?(key) && fields[key].value == value
    value
  end

  def to_hash
    fields.inject({}) do |acc, (key, value)|
      acc[key] = value.value
      acc
    end
  end

  def merge!(other)
    other.each_pair do |key, value|
      self[key] = value
    end
    self
  end

  delegate :key?, :keys, :empty?, to: :fields


  private

  def value_for(key, value)
    Field.new(key, value)

  end

  attr_accessor :fields
end
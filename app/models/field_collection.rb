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
    confirm_field(key)
    unless key?(key) && fields[key].value == value
      send(:"#{key}_will_change", value) unless !respond_to?(:"#{key}_will_change") || (key?(key) && self[key] == value)
      fields[key] = Field.new(key, value)
    end
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

  def invalidate_fields(*fields)
    fields.each do |field|
      invalidate_field field
    end
  end

  def invalidate_field(field)
    if key?(field)
      fields[field].invalidate
    end
  end

  def confirm_field(field)
    fields[field].confirm if key?(field)
  end

  delegate :key?, :keys, :empty?, to: :fields


  private

  def value_for(key, value)
    Field.new(key, value)

  end

  attr_accessor :fields
end
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
    unless key_equals?(key, value)
      notify_key_change(key, value)
      fields[key] = Field.new(key, value)
    end
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

  def valid_only
    clone.tap do |new_obj|
      new_obj.fields.reject! { |_, field| field.invalidated }
    end
  end

  def clone
    super.tap do |o|
      o.fields = o.fields.clone
    end
  end

  delegate :key?, :keys, :empty?, to: :fields

  private

  def notify_key_change(key, value)
    m = :"#{key}_will_change"
    send(m, value) unless !respond_to?(m) || key_equals?(key, value)
  end

  def key_equals?(key, value)
    key?(key) && self[key] == value
  end

  def value_for(key, value)
    Field.new(key, value)
  end

  protected

  attr_accessor :fields
end

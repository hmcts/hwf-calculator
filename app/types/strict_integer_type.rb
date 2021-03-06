class StrictIntegerType < ActiveModel::Type::Integer
  NUMERIC_RE = /\A\s*(?:\-?)(\d)+\s*\z/

  def cast(value)
    value = value.delete(',') if value.is_a?(String)
    if value.is_a?(String) && NUMERIC_RE.match(value).nil?
      return value
    end
    super
  end
end

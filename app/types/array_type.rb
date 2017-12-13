class ArrayType < ActiveModel::Type::Value
  def cast(value)
    value
  end
end

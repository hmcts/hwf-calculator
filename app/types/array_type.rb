# Allows for an array to be used as an active model type
class ArrayType < ActiveModel::Type::Value
  def cast(value)
    value
  end
end

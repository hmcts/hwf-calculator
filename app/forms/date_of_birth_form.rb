class DateOfBirthForm < BaseForm
  attribute :date_of_birth, :date

  def type
    :date_of_birth
  end

  def initialize(inputs = {})
    super convert_date_input(inputs)
  end

  private

  # @TODO This method is responsibe for converting from rails's 1i, 2i, 3i format for dates
  # - this may well get changed but not focusing on this right now
  def convert_date_input(data)
    return data unless data.key?('date_of_birth(1i)') &&
                       data.key?('date_of_birth(2i)') &&
                       data.key?('date_of_birth(3i)')
    inputs = data.dup
    date = Date.new inputs.delete('date_of_birth(1i)').to_i,
      inputs.delete('date_of_birth(2i)').to_i,
      inputs.delete('date_of_birth(3i)').to_i
    inputs.merge(date_of_birth: date)
  end

  def export_params
    {
      date_of_birth: date_of_birth
    }
  end
end

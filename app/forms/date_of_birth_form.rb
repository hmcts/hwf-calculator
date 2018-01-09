# A form object for the date of birth question
# Allows for date's being represented using rails '1i, 2i and 3i' notation.
class DateOfBirthForm < BaseForm
  # @!attribute [rw] date_of_birth
  #   @return [Date] The date of birth of the individual or the main person in a couple
  attribute :date_of_birth, :date
  # @!attribute [rw] partner_date_of_birth
  #   @return [Date,nil] The date of birth of the partner in a couple
  attribute :partner_date_of_birth, :date

  # The type of the form
  #
  # @return [Symbol] :date_of_birth
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
    inputs = data.dup
    convert_date_of_birth(inputs)
    convert_partner_date_of_birth(inputs)
    inputs
  end

  def convert_date_of_birth(inputs)
    return unless inputs.key?('date_of_birth(1i)') &&
      inputs.key?('date_of_birth(2i)') &&
      inputs.key?('date_of_birth(3i)')
    date = Date.new inputs.delete('date_of_birth(1i)').to_i,
      inputs.delete('date_of_birth(2i)').to_i,
      inputs.delete('date_of_birth(3i)').to_i
    inputs.merge!(date_of_birth: date)

  end

  def convert_partner_date_of_birth(inputs)
    year = inputs.delete('partner_date_of_birth(1i)')
    month = inputs.delete('partner_date_of_birth(2i)')
    day = inputs.delete('partner_date_of_birth(3i)')
    return if [year, month, day].any?(&:blank?)
    date = Date.new year.to_i, month.to_i, day.to_i
    inputs.merge!(partner_date_of_birth: date)
  end

  def earliest_date_of_birth
    [date_of_birth, partner_date_of_birth].compact.min
  end

  def export_params
    {
      date_of_birth: earliest_date_of_birth
    }
  end
end

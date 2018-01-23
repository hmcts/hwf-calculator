require 'blank_date'
# A form object for the date of birth question
# Allows for date's being represented using rails '1i, 2i and 3i' notation.
class DateOfBirthForm < BaseForm
  # @!attribute [rw] date_of_birth
  #   @return [Date] The date of birth of the individual or the main person in a couple
  attribute :date_of_birth, :date
  # @!attribute [rw] partner_date_of_birth
  #   @return [Date,nil] The date of birth of the partner in a couple
  attribute :partner_date_of_birth, :date

  validates :date_of_birth, presence: true, age: { greater_than_or_equal_to: 16, allow_nil: true, allow_blank: true }
  validates :partner_date_of_birth,
    presence: true,
    age: {
      greater_than_or_equal_to: 16,
      allow_nil: true,
      allow_blank: true
    },
    allow_nil: true,
    allow_blank: false

  # The type of the form
  #
  # @return [Symbol] :date_of_birth
  def self.type
    :date_of_birth
  end

  def initialize(inputs = {})
    super convert_date_input(inputs)
  end

  private

  # @TODO This method is responsibe for converting from rails's 1i, 2i, 3i format for dates
  # - this may well get changed but not focusing on this right now
  # @TODO Definitely move this into an active model type
  def convert_date_input(data)
    inputs = data.dup
    convert_date_of_birth(inputs)
    convert_partner_date_of_birth(inputs)
    inputs
  end

  def convert_date_of_birth(inputs)
    return if inputs[:date_of_birth].is_a?(Date)
    inputs[:date_of_birth] = convert_rails_date(inputs: inputs, attribute: :date_of_birth)
  end

  def convert_partner_date_of_birth(inputs)
    return if inputs[:partner_date_of_birth].is_a?(Date)
    inputs[:partner_date_of_birth] = convert_rails_date(inputs: inputs, attribute: :partner_date_of_birth)
  end

  def convert_rails_date(inputs:, attribute:)
    year = inputs.delete("#{attribute}(1i)")
    month = inputs.delete("#{attribute}(2i)")
    day = inputs.delete("#{attribute}(3i)")
    if [year, month, day].all?(&:nil?)
      nil
    elsif [year, month, day].any?(&:blank?)
      BlankDate.new
    else
      Date.new year.to_i, month.to_i, day.to_i
    end
  end

  def export_params
    {
      date_of_birth: date_of_birth,
      partner_date_of_birth: partner_date_of_birth
    }
  end
end

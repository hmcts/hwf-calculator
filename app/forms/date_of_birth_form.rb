require 'blank_date'
require 'invalid_date'
# A form object for the date of birth question
# Allows for date's being represented using a hash for each (with keys day, month and year)
class DateOfBirthForm < BaseForm
  # @!attribute [rw] date_of_birth
  #   @return [Date] The date of birth of the individual or the main person in a couple
  attribute :date_of_birth, :strict_date
  # @!attribute [rw] partner_date_of_birth
  #   @return [Date,nil] The date of birth of the partner in a couple
  attribute :partner_date_of_birth, :strict_date

  validates :date_of_birth,
    presence: true,
    strict_date: true,
    age: { greater_than_or_equal_to: 16, allow_nil: true, allow_blank: true, if: :date_of_birth_valid? }
  validates :partner_date_of_birth,
    presence: true,
    strict_date: true,
    age: {
      greater_than_or_equal_to: 16,
      allow_nil: true,
      allow_blank: true,
      if: :partner_date_of_birth_valid?
    },
    allow_nil: true,
    allow_blank: false

  # The type of the form
  #
  # @return [Symbol] :date_of_birth
  def self.type
    :date_of_birth
  end

  private

  def export_params
    {
      date_of_birth: date_of_birth,
      partner_date_of_birth: partner_date_of_birth
    }
  end

  def date_of_birth_valid?
    !date_of_birth.is_a?(InvalidDate)
  end

  def partner_date_of_birth_valid?
    !partner_date_of_birth.is_a?(InvalidDate)
  end
end

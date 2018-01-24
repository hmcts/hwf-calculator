require 'invalid_date'
# This validator will fail if the date provided is an 'InvalidDate' - or whichever invalid date class
# is passed into its config.
# This allows the form object to store an 'InvalidDate' which contains the original values passed by the user
# which keeps it happy as it is still a 'Date' - just an invalid one.
#
# @example Simple Usage
#
#   validates :date_of_birth, date: true
#
# @example With custom invalid date class
#
#   validates :date_of_birth, date: { invalid_date_class: CustomInvalidDate }
#
# Note that at present, the invalid dates are not given out by anything but the individual form objects themselves
# however, these will be moved into custom date types so all form objects can have this stuff.
# @TODO Review the comment above
class DateValidator < ActiveModel::EachValidator
  def initialize(invalid_date_class: InvalidDate, **args)
    self.invalid_date_class = invalid_date_class
    super(args)
  end

  def validate_each(record, attribute, value)
    return if value.nil? || value.blank?
    record.errors.add(attribute, :invalid_date) if value.is_a?(invalid_date_class)
  end

  private

  attr_accessor :invalid_date_class
end

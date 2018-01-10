class AgeValidator < ActiveModel::EachValidator
  def initialize(age_service: AgeService, **args)
    self.age_service = age_service
    super(args)
  end

  def validate_each(record, attribute, value)
    return if value.nil? || value.blank?
    age = age_service.call(date_of_birth: value)
    if options.key?(:greater_than_or_equal_to)
      gte = options[:greater_than_or_equal_to]
      record.errors.add(attribute, :age_less_than, count: gte) unless age >= gte
    end
  end

  private

  attr_accessor :age_service
end

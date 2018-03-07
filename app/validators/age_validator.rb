class AgeValidator < ActiveModel::EachValidator
  def initialize(age_service: AgeService, **args)
    self.age_service = age_service
    super(args)
  end

  def validate_each(record, attribute, value)
    return if value.nil? || value.blank?
    age = age_service.call(date_of_birth: value)
    validate_gte(age, attribute, record)
    validate_lte(age, attribute, record)
  end

  private

  def validate_lte(age, attribute, record)
    if options.key?(:less_than_or_equal_to)
      lte = options[:less_than_or_equal_to]
      record.errors.add(attribute, :age_greater_than, count: lte) unless age <= lte
    end
  end

  def validate_gte(age, attribute, record)
    if options.key?(:greater_than_or_equal_to)
      gte = options[:greater_than_or_equal_to]
      record.errors.add(attribute, :age_less_than, count: gte) unless age >= gte
    end
  end

  attr_accessor :age_service
end

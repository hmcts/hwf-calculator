# A repository to persist the calculation to a hash like store
# the store can be a rails session.
class CalculationRepository
  KEY = :calculator_repository

  # Creates a new repository backed by a given store
  # @param [#fetch,#delete,#[]=] store A hash like store that must support fetch, delete and []=
  def initialize(store:)
    self.store = store
  end

  # Finds the single calculation in the repo.  If none existed a new one is created
  #
  # @return [Calculation] The calculation instance from the repo
  def find
    data = store.fetch(KEY) do
      encode(Calculation.new)
    end
    decode(data)
  end

  # @param [Calculation] calculation The calculation to save
  # @return [Boolean] true if successful
  def save(calculation)
    store[KEY] = encode(calculation)
    true
  end

  # Deletes all calculations from the repository
  # @return [Calculation] Returns self for chaining
  def delete_all
    store.delete(KEY)
    self
  end

  private

  def encode(obj)
    YAML.dump(obj)
  end

  def decode(data)
    YAML.safe_load(data, [Calculation, Symbol, Date, CalculatorFieldCollection, Field])
  end

  attr_accessor :store
end

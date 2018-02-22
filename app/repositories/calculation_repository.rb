class CalculationRepository
  KEY = :calculator_repository

  def initialize(store:)
    self.store = store
  end

  def find
    data = store.fetch(KEY) do
      YAML.dump(Calculation.new)
    end
    decode(data)
  end

  def save(calculation)
    store[KEY] = encode(calculation)
  end

  def delete_all
    store.delete(KEY)
    self
  end

  private

  def encode(obj)
    YAML.dump(obj) 
  end

  def decode(data)
    YAML.load(data) 
  end

  attr_accessor :store
end

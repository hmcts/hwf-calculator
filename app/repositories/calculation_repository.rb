# A repository to persist the calculation to a hash like store
# the store can be a rails session.
class CalculationRepository
  require 'zlib'
  class InvalidVersion < RuntimeError

  end
  KEY = :calculator_repository
  # The version of repository
  # This repo stores things in the users session, which ends up being a signed cookie.
  # If we add, remove or change things to the repo, you may want to just forget the old
  # version in the session.
  # To do this, simply increase the version number in this method and anything that was serialized
  # before this version will be scrapped.
  def self.version
    1
  end

  # Creates a new repository backed by a given store
  # @param [#fetch,#delete,#[]=] store A hash like store that must support fetch, delete and []=
  def initialize(store:, version: self.class.version)
    self.store = store
    self.version = version
  end

  # Finds the single calculation in the repo.  If none existed a new one is created
  #
  # @return [Calculation] The calculation instance from the repo
  def find
    retry_once do
      data = store.fetch(KEY) do
        encode(Calculation.new)
      end
      calc, version = decode(data)
      validate_version(version)
      calc.tap(&:freeze_if_frozen)
    end
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

  def retry_once
    begin
      return yield
    rescue InvalidVersion, Psych::Exception, Zlib::DataError
      delete_all
    end
    yield
  end

  def validate_version(found_version)
    raise InvalidVersion if found_version != version
  end

  def encode(obj)
    compress YAML.dump([obj, version])
  end

  def decode(data)
    YAML.safe_load(decompress(data), [Calculation, Symbol, Date, CalculatorFieldCollection, Field])
  end

  def compress(data)
    Zlib::Deflate.deflate(data).to_yaml
  end

  def decompress(data)
    Zlib::Inflate.inflate(YAML.safe_load(data))
  end

  attr_accessor :store, :version
end

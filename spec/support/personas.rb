module Calculator
  module Test
    module PersonasHelper

      # @return [Calculator::Test::PersonasRepository]
      def personas
        @personas ||= ::Calculator::Test::PersonasRepository.new
      end
    end
  end
end

RSpec.configure do |c|
  c.include ::Calculator::Test::PersonasHelper
end
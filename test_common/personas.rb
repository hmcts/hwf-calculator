module Calculator
  module Test
    class PersonasRepository
      PERSONAS_FILE = File.absolute_path('../fixtures/personas.yml', __FILE__)
      def initialize
        self.registry = {}
      end

      def fetch(name)
        ensure_loaded
        OpenStruct.new registry.fetch(name)
      end

      private

      def ensure_loaded
        load unless loaded?
      end

      def loaded?
        loaded
      end

      def load
        self.registry = YAML.load_file(PERSONAS_FILE).symbolize_keys
        self.loaded = true
      end

      attr_accessor :registry, :loaded
    end
  end
end

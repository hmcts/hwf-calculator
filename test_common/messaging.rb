require 'i18n'
module Calculator
  module Test
    class Backend < ::I18n::Backend::Simple
      def initialize(messaging_dir:)
        super()
        load_translations Dir.glob(File.join(messaging_dir, '**', '*.yml'))
        @initialized = true
      end
    end

    class Messaging
      def initialize(messaging_dir: File.absolute_path('../messaging', __FILE__))
        self.backend = Backend.new(messaging_dir: messaging_dir)
      end

      def self.instance
        Thread.current[:calculator_test_messaging_instance] ||= new
      end

      def translate(key, locale: :en, **options)
        result = catch(:exception) do
          backend.translate(locale, key, options)
        end
        result.is_a?(::I18n::MissingTranslation) ? raise(result) : result
      end

      alias t translate

      private

      attr_accessor :backend
    end

    module I18n
      extend ActiveSupport::Concern

      def t(*args)
        ::Calculator::Test::Messaging.instance.t(*args)
      end

      class_methods do
        def t(*args)
          ::Calculator::Test::Messaging.instance.t(*args)
        end
      end
    end
  end
end

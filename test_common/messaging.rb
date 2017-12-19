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

      def translate(key, locale: :en, **options)
        result = catch(:exception) do
          backend.translate(locale, key, options)
        end
        result.is_a?(I18n::MissingTranslation) ? raise(result) : result
      end

      alias_method :t, :translate

      private

      attr_accessor :backend
    end
  end
end

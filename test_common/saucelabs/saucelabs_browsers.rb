module Calculator
  module Test
    module Saucelabs
      def self.browsers
        @browsers = begin
          browsers = YAML.load_file(File.absolute_path(File.join('..', 'browsers.yml'), __FILE__))['saucelabs']['browsers']
          browsers.each_pair do |name, config|
            config['name'] = "HWF Calculator #{config['name']}"
          end
          browsers
        end
      end
    end
  end
end
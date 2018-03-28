module Calculator
  module Test
    module Ngrok
      module Tunnel
        def self.before_all
          return unless ENV.fetch('CAPYBARA_USE_NGROK', 'false') == 'true'
          Capybara.using_driver Capybara.javascript_driver do
            server = Capybara.current_session.server
            backend_host_port = if server
                                  "#{server.host}:#{server.port}"
                                else
                                  u = URI.parse(Capybara.app_host)
                                  "#{u.host}:#{u.port}"
                                end
            ::Ngrok::Tunnel.start addr: backend_host_port, inspect: false, region: 'eu'
            Capybara.app_host = "#{::Ngrok::Tunnel.ngrok_url}:80"
          end

        end

        def self.after_all
          return unless ENV.fetch('CAPYBARA_USE_NGROK', 'false') == 'true'
          ::Ngrok::Tunnel.stop
        end
      end
    end
  end
end
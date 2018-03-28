RSpec.configure do |c|
  c.before :suite do
    next unless ENV.fetch('CAPYBARA_USE_NGROK', 'false') == 'true'
    d = Capybara.current_driver
    Capybara.using_driver Capybara.javascript_driver do
      server = Capybara.current_session.server
      backend_host_port = if server
                            "#{server.host}:#{server.port}"
                          else
                            u = URI.parse(Capybara.app_host)
                            "#{u.host}:#{u.port}"
                          end
      Ngrok::Tunnel.start addr: backend_host_port, inspect: false, region: 'eu'
      Capybara.app_host = "#{Ngrok::Tunnel.ngrok_url}:80"
    end
  end

  c.after :suite do
    next unless ENV.fetch('CAPYBARA_USE_NGROK', 'false') == 'true'
    Ngrok::Tunnel.stop
  end
end
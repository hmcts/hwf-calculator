allow = [Capybara.server_host]
allow << URI.parse(ENV['SELENIUM_URL']).host if ENV.key?('SELENIUM_URL')
WebMock.disable_net_connect!(allow_localhost: true, allow: allow)

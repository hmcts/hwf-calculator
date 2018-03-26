Capybara.configure do |config|
  driver = ENV.fetch('DRIVER', 'chromedriver').to_sym
  config.javascript_driver = driver
  config.default_max_wait_time = 10
  config.match = :prefer_exact
  config.exact = true
  config.ignore_hidden_elements = false
  config.visible_text_only = true
end

Capybara.register_driver :firefox do |app|
  profile = Selenium::WebDriver::Firefox::Profile.new
  profile['browser.cache.disk.enable'] = false
  profile['browser.cache.memory.enable'] = false
  Capybara::Selenium::Driver.new(app, browser: :firefox, profile: profile)
end

Capybara.register_driver :chrome do |app|
  Capybara::Selenium::Driver.new(app, browser: :chrome, url: ENV.fetch('SELENIUM_URL', 'http://localhost:4444/wd/hub'))
end

Capybara.register_driver :chromedriver do |app|
  options = Selenium::WebDriver::Chrome::Options.new
  options.add_argument('--no-sandbox')
  options.add_argument('--headless')
  Capybara::Selenium::Driver.new(app, browser: :chrome, options: options)
end

Capybara.register_driver :firefoxdriver do |app|
  options = Selenium::WebDriver::Firefox::Options.new
  options.headless!
  Capybara::Selenium::Driver.new(app, browser: :firefox, options: options)
end

Capybara.register_driver :safari do |app|
  Capybara::Selenium::Driver.new(app, browser: :safari)
end

Capybara.register_driver :zap do |app|
  zap_url = ENV.fetch('ZAP_HOST', 'http://0.0.0.0:8095')

  options = Selenium::WebDriver::Chrome::Options.new
  options.add_argument('--no-sandbox')
  options.add_argument('--headless')
  options.add_argument("--proxy-server=#{zap_url}")
  Capybara::Selenium::Driver.new(app, browser: :chrome, options: options)
end

Capybara.always_include_port = true
Capybara.server_host = ENV.fetch('CAPYBARA_SERVER_HOST', ENV.fetch('HOSTNAME', '0.0.0.0'))
Capybara.server_port = ENV.fetch('CAPYBARA_SERVER_PORT', '3000')

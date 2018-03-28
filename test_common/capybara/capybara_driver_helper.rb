require_relative '../saucelabs/saucelabs_browsers'
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

Calculator::Test::Saucelabs.browsers.each_pair do |name, caps|
  sauce_endpoint = "http://#{ENV.fetch('SAUCE_USERNAME')}:#{ENV.fetch('SAUCE_ACCESS_KEY')}@ondemand.saucelabs.com:80/wd/hub"
  selenium_url = ENV.fetch('SELENIUM_URL', sauce_endpoint)
  Capybara.register_driver :"sauce_#{name}" do |app|
    Capybara::Selenium::Driver.new(app, :browser => :remote, :url => selenium_url, :desired_capabilities => caps)
  end
end

Capybara.register_driver :saucelabs do |app|
  sauce_endpoint = "http://#{ENV.fetch('SAUCE_USERNAME')}:#{ENV.fetch('SAUCE_ACCESS_KEY')}@ondemand.saucelabs.com:80/wd/hub"
  caps = { :platform => "Mac OS X 10.9", :browserName => "Chrome", :version => "31", name: "Saucelabs Browser Test For HWF Calculator" }
  Capybara::Selenium::Driver.new(app,
    :browser => :remote, :url => ENV.fetch('SELENIUM_URL', sauce_endpoint),
    :desired_capabilities => caps)
end

Capybara.always_include_port = true
Capybara.app_host = ENV.fetch('CAPYBARA_APP_HOST', "http://#{ENV.fetch('HOSTNAME', 'localhost')}")
Capybara.server_host = ENV.fetch('CAPYBARA_SERVER_HOST', ENV.fetch('HOSTNAME', 'localhost'))
Capybara.server_port = ENV.fetch('CAPYBARA_SERVER_PORT') if ENV['CAPYBARA_SERVER_PORT']

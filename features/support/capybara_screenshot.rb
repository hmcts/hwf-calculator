require 'capybara-screenshot/cucumber'
require_relative 'test_common'
Capybara::Screenshot.prune_strategy = :keep_last_run
Capybara::Screenshot.register_driver(:chrome) do |driver, path|
  driver.browser.save_screenshot(path)
end

Calculator::Test::Saucelabs.browsers.keys.each do |browser|
  Capybara::Screenshot.register_driver(browser) do |driver, path|
    driver.browser.save_screenshot(path)
  end
end

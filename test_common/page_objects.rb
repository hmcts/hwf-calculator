require_relative 'capybara_selectors'
require_relative 'sections'
require_relative 'page_objects/calculator/base_page'
require_relative 'page_objects/calculator/base_popup_page'
Dir.glob(File.absolute_path('../page_objects/**/*.rb', __FILE__)).each { |f| require f }

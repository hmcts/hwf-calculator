require_relative './test_common'
RSpec.configure do |c|
  c.before :suite do
    Calculator::Test::Ngrok::Tunnel.before_all
  end

  c.after :suite do
    Calculator::Test::Ngrok::Tunnel.after_all
  end
end
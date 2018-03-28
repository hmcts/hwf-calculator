require_relative './test_common'
Calculator::Test::Ngrok::Tunnel.before_all

at_exit do
  Calculator::Test::Ngrok::Tunnel.after_all
end

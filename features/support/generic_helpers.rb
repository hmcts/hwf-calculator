# rubocop:disable Style/TrivialAccessors
def user=(user)
  @user = user
end

def user
  @user
end
# rubocop:enable Style/TrivialAccessors

def calculator_start_page
  @calculator_start_page ||= ::Calculator::Test::En::StartPage.new
end

def calculator_marital_status_page
  @calculator_marital_status_page ||= ::Calculator::Test::En::MaritalStatusPage.new
end

def calculator_court_fee_page
  @calculator_court_fee_page ||= ::Calculator::Test::En::CourtFeePage.new
end

def calculator_date_of_birth_page
  @calculator_date_of_birth_page ||= ::Calculator::Test::En::DateOfBirthPage.new
end

def calculator_disposable_capital_page
  @calculator_disposable_capital_page ||= ::Calculator::Test::En::DisposableCapitalPage.new
end

def any_calculator_page
  @any_calculator_page ||= ::Calculator::Test::En::BasePage.new
end

def personas
  @personas ||= ::Calculator::Test::PersonasRepository.new
end

def messaging
  @messaging ||= begin
    ::Calculator::Test::Messaging.new
  end
end

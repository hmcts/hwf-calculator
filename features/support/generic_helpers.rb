# rubocop:disable Style/TrivialAccessors
def user=(user)
  @user = user
end

def user
  @user
end
# rubocop:enable Style/TrivialAccessors

def start_page
  @start_page ||= ::Calculator::Test::En::StartPage.new
end

def marital_status_page
  @marital_status_page ||= ::Calculator::Test::En::MaritalStatusPage.new
end

def court_fee_page
  @court_fee_page ||= ::Calculator::Test::En::CourtFeePage.new
end

def date_of_birth_page
  @date_of_birth_page ||= ::Calculator::Test::En::DateOfBirthPage.new
end

def disposable_capital_page
  @disposable_capital_page ||= ::Calculator::Test::En::DisposableCapitalPage.new
end

def income_benefits_page
  @income_benefits_page ||= ::Calculator::Test::En::IncomeBenefitsPage.new
end

def number_of_children_page
  @number_of_children_page ||= ::Calculator::Test::En::NumberOfChildrenPage.new
end

def full_remission_page
  @full_remission_page ||= ::Calculator::Test::En::FullRemissionPage.new
end

def any_calculator_page
  @any_calculator_page ||= ::Calculator::Test::En::BasePage.new
end

def personas
  @personas ||= ::Calculator::Test::PersonasRepository.new
end

def messaging
  @messaging ||= ::Calculator::Test::Messaging.new
end

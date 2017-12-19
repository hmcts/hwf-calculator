Rails.application.routes.draw do
  root controller: :calculation, action: :home
  resource :calculation, controller: :calculation, only: [:update]
  get '/calculation/:form' => "calculation#edit", as: :edit_calculation
end

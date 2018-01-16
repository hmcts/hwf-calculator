Rails.application.routes.draw do
  root controller: :calculation, action: :home
  resource :calculation, controller: :calculation, only: [:update], path: '/calculation/:form'
  get '/calculation/:form' => "calculation#edit", as: :edit_calculation

end

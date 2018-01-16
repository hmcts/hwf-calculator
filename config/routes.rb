Rails.application.routes.draw do
  root controller: :calculation, action: :home
  resource :calculation, controller: :calculation, only: [:update]
  get '/calculation/:form' => "calculation#edit", as: :edit_calculation
  patch '/calculation/:form' => 'calculation#update', as: :update_calculation
  patch '/calculation' => 'calculation#update', as: :start_calculation
end

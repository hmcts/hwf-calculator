Rails.application.routes.draw do
  root controller: :calculation, action: :home
  resource :calculation, controller: :calculation, only: [:update]
  get '/calculation/:form' => "calculation#edit", as: :edit_calculation
  get '/calculation_result/full_remission' => 'calculation_result#full_remission_available', as: :calculation_result_full
  get '/calculation_result/partial_remission' => 'calculation_result#partial_remission_available', as: :calculation_result_partial
  get '/calculation_result/not_eligible' => 'calculation_result#no_remission_available', as: :calculation_result_none
  patch '/calculation/:form' => 'calculation#update', as: :update_calculation
  patch '/calculation' => 'calculation#update', as: :start_calculation
end

Rails.application.routes.draw do
  root controller: :calculation, action: :home
  resource :calculation, controller: :calculation, only: [:edit, :update]
end

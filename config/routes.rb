Rails.application.routes.draw do
  resources :checks

  get 'balance', to: 'checks#show'

  root to: 'checks#new'
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end

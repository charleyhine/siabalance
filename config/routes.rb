Rails.application.routes.draw do
  resources :checks

  root to: 'checks#new'
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end

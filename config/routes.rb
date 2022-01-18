Rails.application.routes.draw do
  root to: 'home#index'
  devise_for :users

  resources :merchants, except: [:create]
end

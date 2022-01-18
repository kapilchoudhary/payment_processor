Rails.application.routes.draw do
  root to: 'home#index'
  devise_for :users

  resources :merchants, except: [:create]

  namespace :api do
    namespace :v1 do
      resources :transactions, only: [:create] do
        member do
          put :charge_transaction
          put :refund_transaction
          put :reversal_transaction
        end
      end
      post :authenticate, to: 'account#authenticate'
    end
  end  
end

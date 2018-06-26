Rails.application.routes.draw do
  namespace :api do
    namespace :v1 do
      # Items
      get 'items/find', to: 'items/search#show'
      get 'items/find_all', to: 'items/search#index'
      resources :items, only: [:index, :show]

      # Merchants
      get 'merchants/find', to: 'merchants/search#show'
      resources :merchants, only: [:index, :show]
    end
  end
end

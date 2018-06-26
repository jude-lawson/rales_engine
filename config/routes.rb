Rails.application.routes.draw do
  namespace :api do
    namespace :v1 do
      # Items
      get 'items/find', to: 'items/search#show'
      get 'items/find_all', to: 'items/search#index'
      get 'items/random', to: 'items/random#show'
      resources :items, only: [:show, :index] do
        get 'merchant', to: 'items/merchant#show'
      end

      # Merchants
      get 'merchants/find', to: 'merchants/search#show'
      get 'merchants/find_all', to: 'merchants/search#index'
      get 'merchants/random', to: 'merchants/random#show'
      resources :merchants, only: [:index, :show] do
        get 'items', to: 'merchants/items#show'
        get 'invoices', to: 'merchants/invoices#show'
      end

      # Invoices
      get 'invoices/find', to: 'invoices/search#show'
      get 'invoices/find_all', to: 'invoices/search#index'
      get 'invoices/random', to: 'invoices/random#show'
      resources :invoices, only: [:index, :show]

      # Invoice Items
      get 'invoice_items/find', to: 'invoice_items/search#show'
      get 'invoice_items/find_all', to: 'invoice_items/search#index'
      get 'invoice_items/random', to: 'invoice_items/random#show'
      resources :invoice_items, only: [:index, :show]
    end
  end
end

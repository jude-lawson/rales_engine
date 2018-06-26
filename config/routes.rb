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
      get 'invoices/:id/transactions', to: 'invoices/transactions#index'
      get 'invoices/:id/invoice_items', to: 'invoices/invoice_items#index'
      get 'invoices/:id/items', to: 'invoices/items#index'
      resources :invoices, only: [:index, :show]

      # Invoice Items
      get 'invoice_items/find', to: 'invoice_items/search#show'
      get 'invoice_items/find_all', to: 'invoice_items/search#index'
      get 'invoice_items/random', to: 'invoice_items/random#show'
      resources :invoice_items, only: [:index, :show]

      # Transactions
      get 'transactions/find', to: 'transactions/search#show'
      get 'transactions/find_all', to: 'transactions/search#index'
      get 'transactions/random', to: 'transactions/random#show'
      resources :transactions, only: [:index, :show]

      # Customers
      get 'customers/find', to: 'customers/search#show'
      get 'customers/find_all', to: 'customers/search#index'
      get 'customers/random', to: 'customers/random#show'
      resources :customers, only: [:index, :show]
    end
  end
end

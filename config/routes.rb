Rails.application.routes.draw do
  namespace :api do
    namespace :v1 do
      # Items
      get 'items/find', to: 'items/search#show'
      get 'items/find_all', to: 'items/search#index'
      get 'items/random', to: 'items/random#show'
      get 'items/:id/invoice_items', to: 'items/invoice_items#index'
      get 'items/:id/merchant', to: 'items/merchants#show'
      get 'items/most_revenue', to: 'items/most_revenue#index'
      get 'items/most_items', to: 'items/most_items#index'
      get 'items/:id/best_day', to: 'items/best_day#show'
      resources :items, only: [:show, :index]

      # Merchants
      get 'merchants/find', to: 'merchants/search#show'
      get 'merchants/find_all', to: 'merchants/search#index'
      get 'merchants/random', to: 'merchants/random#show'
      get 'merchants/:id/customers_with_pending_invoices', to: 'merchants/pending_invoices#index'
      get 'merchants/most_revenue', to: 'merchants/most_revenue#index'
      get 'merchants/most_items', to: 'merchants/most_items#index'
      get 'merchants/revenue', to: 'merchants/revenue_by_date#show'
      resources :merchants, only: [:index, :show] do
        get 'items', to: 'merchants/items#show'
        get 'invoices', to: 'merchants/invoices#index'
        get 'favorite_customer', to: 'merchants/customers#show'
      end

      # Invoices
      get 'invoices/find', to: 'invoices/search#show'
      get 'invoices/find_all', to: 'invoices/search#index'
      get 'invoices/random', to: 'invoices/random#show'
      get 'invoices/:id/transactions', to: 'invoices/transactions#index'
      get 'invoices/:id/invoice_items', to: 'invoices/invoice_items#index'
      get 'invoices/:id/items', to: 'invoices/items#index'
      get 'invoices/:id/customer', to: 'invoices/customers#show'
      get 'invoices/:id/merchant', to: 'invoices/merchants#show'
      resources :invoices, only: [:index, :show]

      # Invoice Items
      get 'invoice_items/find', to: 'invoice_items/search#show'
      get 'invoice_items/find_all', to: 'invoice_items/search#index'
      get 'invoice_items/random', to: 'invoice_items/random#show'
      get 'invoice_items/:id/invoice', to: 'invoice_items/invoices#show'
      get 'invoice_items/:id/item', to: 'invoice_items/items#show'
      resources :invoice_items, only: [:index, :show]

      # Transactions
      get 'transactions/find', to: 'transactions/search#show'
      get 'transactions/find_all', to: 'transactions/search#index'
      get 'transactions/random', to: 'transactions/random#show'
      resources :transactions, only: [:index, :show] do
        get 'invoice', to: 'transactions/invoices#show'
      end

      # Customers
      get 'customers/find', to: 'customers/search#show'
      get 'customers/find_all', to: 'customers/search#index'
      get 'customers/random', to: 'customers/random#show'
      get 'customers/:id/favorite_merchant', to: 'customers/favorite_merchant#show'
      resources :customers, only: [:index, :show] do
        get 'invoices', to: 'customers/invoices#index'
        get 'transactions', to: 'customers/transactions#index'
      end
    end
  end
end

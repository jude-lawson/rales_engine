Rails.application.routes.draw do
  namespace :api do
    namespace :v1 do
      get 'items/find', to: 'items/search#show'
      get 'items/find_all', to: 'items/search#index'
      resources :items, only: [:index, :show]
      get 'invoices/find', to: 'invoices/search#show'
      get 'invoices/find_all', to: 'invoices/search#index'
      resources :invoices, only: [:index, :show]
      get 'invoice_items/find', to: 'invoice_items/search#show'
      get 'invoice_items/find_all', to: 'invoice_items/search#index'
      resources :invoice_items, only: [:index, :show]
    end
  end
end

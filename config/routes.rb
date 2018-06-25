Rails.application.routes.draw do
  namespace :api do
    namespace :v1 do
      get 'items/find', to: 'items/search#show'
      get 'items/find_all', to: 'items/search#index'
      resources :items, only: [:index, :show]
    end
  end
end

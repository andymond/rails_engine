Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html

  namespace :api do
    namespace :v1 do
      namespace :customers do
        get "find", to: "search#show"
        get "find_all", to: "search#index"
        get "random", to: "random#show"
      end
      namespace :merchants do
        get "/find", to: "search#show"
        get "/find_all", to: "search#index"
        get "/random", to: "random#show"
      end
      namespace :transactions do
        get "/find", to: "search#show"
        get "/find_all", to: "search#index"
        get "/random", to: "random#show"
      end
      resources :transactions, only: [:index, :show]
      resources :merchants, only: [:index, :show]
      resources :customers, only: [:index, :show]
      namespace :items do
        get "/find", to: "search#show"
        get "/find_all", to: "search#index"
      end
      resources :items, only: [:index, :show]
      namespace :invoice_items do
        get "/find", to: "search#show"
        get "/find_all", to: "search#index"
      end
      resources :invoice_items, only: [:index, :show]
      namespace :invoices do
        get "/find", to: "search#show"
      end
      resources :invoices, only: [:index, :show]
    end
  end

end

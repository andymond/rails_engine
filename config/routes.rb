Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  namespace :api do
    namespace :v1 do
      namespace :customers do
        get "find", to: "search#show"
        get "find_all", to: "search#index"
        get "random", to: "random#show"
        get "/:id/invoices", to: "invoices#index"
        get "/:id/transactions", to: "transactions#index"
      end
      namespace :merchants do
        get "/find", to: "search#show"
        get "/find_all", to: "search#index"
        get "/random", to: "random#show"
        get "/:id/items", to: "items#index"
        get "/:id/invoices", to: "invoices#index"
      end
      namespace :transactions do
        get "/find", to: "search#show"
        get "/find_all", to: "search#index"
        get "/random", to: "random#show"
        get "/:id/invoice", to: "invoices#show"
      end
      namespace :items do
        get "/random", to: "random#show"
        get "/find", to: "search#show"
        get "/find_all", to: "search#index"
      end
      namespace :invoice_items do
        get "/random", to: "random#show"
        get "/find", to: "search#show"
        get "/find_all", to: "search#index"
      end
      namespace :invoices do
        get "/random", to: "random#show"
        get "/find", to: "search#show"
        get "/find_all", to: "search#index"
        get "/:id/transactions", to: "transactions#index"
        get "/:id/invoice_items", to: "invoice_items#index"
        get "/:id/items", to: "items#index"
        get "/:id/customer", to: "customers#show"
      end
      resources :transactions, only: [:index, :show]
      resources :merchants, only: [:index, :show]
      resources :customers, only: [:index, :show]
      resources :items, only: [:index, :show]
      resources :invoice_items, only: [:index, :show]
      resources :invoices, only: [:index, :show]
    end
  end
end

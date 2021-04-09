Rails.application.routes.draw do
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  root to: 'product_routes#index'
  resources :products
  resources :criteria_definitions
  match 'product_routes/search', to: 'product_routes#search', via: [:get, :post]
  resources :product_routes, only: [:index]
end

Rails.application.routes.draw do
  root 'store#index', as: 'store_index'
  
  resources :line_items do
    collection do
      get 'decrement(/:id)', to: 'line_items#decrement'
    end
  end

  resources :carts
  resources :products
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end

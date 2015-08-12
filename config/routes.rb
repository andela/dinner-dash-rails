Rails.application.routes.draw do

  root "welcome#index"
  resources :foods
  resources :categories
  resources :cart_items
  resources :carts
  resources :about
  resources :users do
    resources :orders
  end

  delete 'carts/:item_id/', to: 'carts#destroy', as: "cart_item_delete"
  get 'login' => 'sessions#new'
  post 'login' => 'sessions#create'
  delete 'logout' => 'sessions#destroy'
  # delete 'carts', to: 'carts#destroy', as: "checkout"

end

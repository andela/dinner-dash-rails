Rails.application.routes.draw do

  root "welcome#index"
  resources :foods do
    resources :comments
  end
  resources :categories
  resources :cart_items
  resources :carts
  resources :administrator
  resources :about
  resources :users do
    resources :orders
  end

  delete 'carts/:item_id/', to: 'carts#destroy', as: "cart_item_delete"
  get 'login' => 'sessions#new'
  post 'login' => 'sessions#create'
  delete 'logout' => 'sessions#destroy'
  post 'checkout' => 'checkout#show', as: :checkout
  post 'carts/checkout' => 'carts#checkout', as: :cart_checkout
  post 'payment' => 'checkout#create', as: :payment
  # delete 'carts', to: 'carts#destroy', as: "checkout"
  post '/foods/:food_id/comments(.:format)' => 'comments#create', as: :create_food_comment
  get 'dashboard' => 'administrator#show', as: :dashboard
  get 'admin_foods' => 'administrator#food_index', as: :admin_foods
  get 'admin_orders' => 'administrator#order_index', as: :admin_orders
  get 'admin_users' => 'administrator#user_index', as: :admin_users
  patch 'order_status' => 'administrator#update', as: :order_status
end
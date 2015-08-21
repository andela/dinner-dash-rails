Rails.application.routes.draw do

  root "welcome#index"
  resources :foods do
    resources :comments
  end
  resources :categories
  resources :cart_items
  resources :carts
  resources :about
  resources :users do
    resources :orders
  end

  get 'login' => 'sessions#new'
  get 'admin/foods' => 'admin#foods', as: :admin_foods
  post 'login' => 'sessions#create'
  post 'checkout' => 'checkout#show', as: :checkout
  post 'carts/checkout' => 'carts#checkout', as: :cart_checkout
  post 'payment' => 'checkout#create', as: :payment
  post '/foods/:food_id/comments(.:format)' => 'comments#create', as: :create_food_comment
  patch '/foods/:food_id/edit_status' => "foods#edit_status", as: :edit_status
  delete 'logout' => 'sessions#destroy'
  delete 'carts/:item_id/', to: 'carts#destroy', as: :cart_item_delete
end

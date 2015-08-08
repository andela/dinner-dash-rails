class CartsController < ApplicationController

  def index
   @cart_items = session[:cart]
     @ordered_food = []
     @total = 0
     @cart_items.each do |food_id, qty|
      food = Food.find(food_id)
      @ordered_food << [food , qty]
      @total += (food.price * qty)
    end
  end
end

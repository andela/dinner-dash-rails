class CartsController < ApplicationController

  def index
    # require 'pry'; binding.pry
   @cart_items = session[:cart]
     @ordered_food = []
     @total = 0
     @cart_items.each do |food_id, qty|
      food = Food.where(id: food_id).first
      @ordered_food << [food , qty]
      @total += (food.price * qty)
    end 
  end

  def destroy
    food_id = params[:id]
    @cart.cart_data.delete(food_id)
    redirect_to carts_path
  end



end

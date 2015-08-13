class CartsController < ApplicationController
  def index
   @cart_items = session[:cart]
    @ordered_food = []
    @total = 0
    @cart_items.each do |food_id, qty|
      food = Food.find(food_id)
      @ordered_food << [food , qty]
      @total += (food.price * qty)
    end if !session[:cart].nil?
    @current_order.ordered_items = @ordered_food
    session[:order] = @ordered_food
  end

  def destroy
    food_id = params[:id]
    @cart.cart_data.delete(food_id)
    redirect_to carts_path
  end
end

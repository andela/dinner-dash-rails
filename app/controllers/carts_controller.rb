class CartsController < ApplicationController
  def index
   @cart_items = session[:cart]
    @ordered_foods = {}
    @total = 0
    @prep_total = 0
    @cart_items.each do |food_id, qty, prep_time|
      food = Food.find(food_id)
      @ordered_foods[food_id] = { :food => food , :qty => qty, :prep_time => prep_time }
      check_food_status(food, qty, food_id, prep_time)
    end if !session[:cart].nil?
    @current_order.ordered_items = @ordered_foods
    session[:order]["items"] = @ordered_foods

  end

  def destroy
    food_id = params[:id]
    @cart.cart_data.delete(food_id)
    redirect_to carts_path
  end

  def check_food_status(food, qty, food_id, prep_time)
    unless food.status == "available"
      @ordered_foods.delete(food_id)
    else
      @total += (food.price * qty)
      @prep_total += (food.prep_time * qty)
    end
  end
end

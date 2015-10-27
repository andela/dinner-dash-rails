class CartsController < ApplicationController
  def index
   @cart_items = session[:cart]
    @ordered_foods = {}
    @total = 0
    @cart_items.each do |food_id, qty|
      food = Food.find(food_id)
      @ordered_foods[food_id] = { :food => food , :qty => qty }
      check_food_status(food, qty, food_id)
    end if !session[:cart].nil?
    @current_order.ordered_items = @ordered_foods
    session[:order]["items"] = @ordered_foods
  end

  def destroy
    food_id = params[:id]
    @cart.cart_data.delete(food_id)
    redirect_to carts_path
  end

  def check_food_status(food, qty, food_id)
    unless food.status == "available"
      @ordered_foods.delete(food_id)
    else
      price =  food.sales[:status] ? food.sales[:price] : food.price
      @total += (price * qty)
    end
  end

end

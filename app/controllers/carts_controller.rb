class CartsController < ApplicationController
  def index
   @cart_items = session[:cart]
    @ordered_foods = {}
    @total = 0
    @prep_total = 0
    @cart_items.each do |food_id, qty, prep_time|
      food = Food.find(food_id)
      prep_time = line_prep_total(qty, food.prep_time) 
      @ordered_foods[food_id] = { :food => food , :qty => qty, :prep_time => prep_time.to_i }
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
      @prep_total += prep_time

    end
  end

   def line_prep_total(qty, prep_time) 
    added_time = (qty/7) * 10
    time = added_time + prep_time;
  end

end

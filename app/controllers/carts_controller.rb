class CartsController < ApplicationController
  def index
    @cart_items = session[:cart]
    @ordered_foods = {}
    @total = 0
    @pickup_time = 0
    @cart_items.each do |food_id, qty, prep_time|
      food = Food.find_by_id(food_id)
      prep_time = line_prep_total(qty, food.prep_time).to_i 
      @ordered_foods[food_id] = { food: food, qty: qty, prep_time: prep_time }
      check_food_status(food, qty, food_id, prep_time)
      @pickup_time += prep_time
      @total_pickup_time = add_extra_time(@pickup_time)
    end unless session[:cart].nil?
    @current_order.ordered_items = @ordered_foods
    session[:order]["details"]["pickup_time"] = @total_pickup_time
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
      price =  food.sales[:status] ? food.sales[:price] : food.price
      @total += (price * qty)
    end
  end

private

  def line_prep_total(qty, prep_time) 
    added_time = ((qty/7) * 10) + prep_time
  end

  def add_extra_time(pick_up_time)
    unless Order.first.nil?
      if (Order.first.Status != "Delivered")
        pick_up_time + 4
      else 
        pick_up_time
      end
    else
    pick_up_time
    end
  end

end

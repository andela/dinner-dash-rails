class CartsController < ApplicationController

  def index
    @cart_items = session[:cart]
    @ordered_food = []
    @total = 0
    @cart_items.each do |food_id, qty|
      food = Food.where(id: food_id).first
      @ordered_food << [food , qty]
      @total += (food.price * qty)
    end if !@cart_items.nil? 
  end

end

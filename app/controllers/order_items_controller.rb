class OrderItemsController < ApplicationController

  def create
  end

  def index
     @cart_items = session[:cart] = {"1" => 2, "2" => 1, "3" => 5}
     @ordered_food = []
     @total = 0
     @cart_items.each do |food_id, qty|
      food = Food.where(id: food_id).first
      @ordered_food << [food , qty]
      @total += (food.price * qty)
    end 
  end

  def destroy
    @ordered_food.delete(params[:id])
    redirect_to order_items_path
  end
end





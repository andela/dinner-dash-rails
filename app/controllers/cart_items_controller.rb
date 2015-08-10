class CartItemsController < ApplicationController
	def create
		@cart.increment(params[:food_id])
		session[:cart] = @cart.cart_data
		redirect_to foods_path
	end

	def destroy
		@cart.destroy
		session.delete(:cart)
	end

	def delete
		@cart.delete(:item_id)
  end

  def update 
    food_id = params[:food_id]
    quantity = params[:quantity][:qty]
    session[:cart][food_id] = quantity.to_i
    redirect_to carts_path
  end

	private

	def cart_params
		params.require(:cart_items).permit(:food_id)
	end

end

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

	private

	def cart_params
		params.require(:cart_items).permit(:food_id)
	end

end

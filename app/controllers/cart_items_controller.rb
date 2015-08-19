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
    args = cart_params
    food_id = args[:food_id]
    quantity = args[:quantity]
    session[:cart][food_id] = quantity.to_i
    session[:order][food_id][1] = quantity.to_i
    render json: {data: food_id}
  end

	private

	def cart_params
		params.require(:cart_items).permit(:food_id, :quantity)
	end

end
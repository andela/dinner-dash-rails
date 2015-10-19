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
    cart = cart_params
    food_id = cart[:food_id]
    quantity = cart[:quantity]
    # prep_time = cart[:prep_time]
    session[:cart][food_id] = quantity.to_i
    session[:order]["items"][food_id]["qty"] = quantity.to_i
		session[:order]["details"] = order_params
    render json: {data: food_id}
  end

	private

	def cart_params
		params.require(:cart_items).permit(:food_id, :quantity)
	end

	def order_params
		params.require(:order_details).permit(:sub_total, :total, :prep_time, :prep_total)
	end
end

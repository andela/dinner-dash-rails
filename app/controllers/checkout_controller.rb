class CheckoutController < ApplicationController
  def show
    if logged_in?
      @current_order.ordered_items = session[:order]
    else 
      redirect_to login_path
    end
  end

  def create
    @current_order.update_order(session[:order], order_params)
    if @current_order.save_order(@current_user)
      flash[:success] = "Your order has been successfully placed."
      redirect_to root_path
      UserMailer.order_email(@current_user, @current_order).deliver_now
    else
      flash[:error] = "An error occured while saving your order. Please try again."
    end
  end

  private

  def order_params
    params.require('order').permit(:total, :delivery_cost, :ordered_items)
  end

end
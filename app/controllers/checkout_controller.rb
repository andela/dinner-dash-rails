class CheckoutController < ApplicationController
  protect_from_forgery :except => [:create]
  def show
    if logged_in?
      @current_order.ordered_items = session[:order]["items"]
    else
      redirect_to login_path
    end
  end

  def create
    puts order_params
    if order_params[:status].downcase === "completed"
      @current_order.update_order(session[:order], order_params)
      if @current_order.save_order(@current_user)
        flash[:success] = "Your order has been successfully placed."
        redirect_to root_path
        UserMailer.order_email(@current_user, @current_order).deliver_now
      else
        flash[:error] = "An error occured while saving your order. Please try again."
      end
    end
  end
  private

  def order_params
    { :invoice => params[:invoice], :status => params[:payment_status], :transaction_id => params[:txn_id]}
  end

end

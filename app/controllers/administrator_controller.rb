class AdministratorController < ApplicationController
  def show
    @orders = Order.all.paginate(page: params[:page], :per_page => 10)
    @title = "orders"
    redirect_to login_path unless logged_in?
  end

  def food_index
    @title = "admin_foods"
    @foods = Food.all
    render template: 'administrator/show.html.erb'
  end

  def order_index
    @title = "orders"
    @orders = Order.all.paginate(page: params[:page], :per_page => 10)
    render template: 'administrator/show.html.erb'
  end

  def user_index
    @title = "users"
    @users = User.all
    render template: 'administrator/show.html.erb'
  end

  def update
    @title = "orders"
    @orders = Order.all.paginate(page: params[:page], :per_page => 10)
    @status = params["order"]["Status"]
    @order_id = params["order_id"]
    @order = Order.find(@order_id)
    @order.update(Status: @status)
    render template: 'administrator/show.html.erb'
  end
end
  
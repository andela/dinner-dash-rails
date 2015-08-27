class AdministratorController < ApplicationController
  def show
    @orders = Order.all.paginate(page: params[:page], :per_page => 10)
    @title = "orders"
    check_if_admin
  end

  def food_index
    @title = "admin_foods"
    @foods = Food.all.order(created_at: :desc)
    check_if_admin
  end

  def order_index
    @title = "orders"
    @orders = Order.all.paginate(page: params[:page], :per_page => 10)
    check_if_admin
  end

  def user_index
    @title = "users"
    @users = User.all.paginate(page: params[:page], :per_page => 10).order(created_at: :desc)
    check_if_admin
  end

  def update
    @title = "orders"
    @orders = Order.all.paginate(page: params[:page], :per_page => 10)
    @status = params["order"]["Status"]
    @order_id = params["order_id"]
    @order = Order.find(@order_id)
    @order.update(Status: @status)
    StatusWorker.perform_async(@order_id)
    check_if_admin
  end
end

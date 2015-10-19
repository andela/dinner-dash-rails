class AdministratorController < ApplicationController

  def show
    @orders = Order.all.paginate(page: params[:page], :per_page => 10)
  end

  def food_index
    @foods = Food.all.order(created_at: :desc)
    respond_to do |format|
      format.js 
    end 
  end

  def order_index
    @orders = Order.all.paginate(page: params[:page], :per_page => 10)
    respond_to do |format|
      format.js 
    end 
  end

  def user_index
    @users = User.all.paginate(page: params[:page], :per_page => 10).order(created_at: :desc)
    respond_to do |format|
      format.js 
    end 
  end

  def category_index
    @categories = Category.all.paginate(page: params[:page], :per_page => 10)
    respond_to do |format|
      format.js 
    end 
  end

  def sale_index
    respond_to do |format|
      format.js 
    end
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

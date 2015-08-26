class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception
  include SessionsHelper

  def set_theme
    @current_theme ||= "full"
  end

  def load_cart
      @cart ||= Cart.new(session[:cart])
  end

  def load_current_order
    session[:order] ||= {}
    @current_order ||= Current_Order.new(session[:order])
  end

  def cart
    @cart
  end

  before_action :set_theme
  before_action :load_cart
  before_action :current_user
  before_action :load_current_order

  helper_method :cart
  helper_method :current_order
end

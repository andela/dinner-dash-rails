require 'test_helper'

class OrdersControllerTest < ActionController::TestCase

  # def setup
  #   @user = User.new(first_name: "Example", last_name: "User", email: "user@example.com")
  #   @order = Order.new(Status: "Cancelled")
  #   @user.orders << @order
  # end

  test "should get index" do
    @user = User.new(first_name: "WE", last_name: "ARE", email: "here")
    @user.save
    @order = Order.new(Status: "Cancelled")
    @user.orders << @order
    # require "pry"; binding.pry
    get :index, user_id: @user.id
    assert_response :success
  end

end

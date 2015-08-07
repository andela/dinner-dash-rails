# require "rails_helper"
#
# RSpec.describe Cart, type: :model do
#   before(:each) do
#     food_id = 1
#     @cart = Cart.new(session[:cart])
#     @cart.increment(food_id)
#     # session[:cart] = @cart.cart_data
#   end
#
#   describe "Place first item in cart" do
#     it "should create a new cart" do
#       expect(@cart).to exist
#       expect(session[:cart]).to exist
#     end
#
#     it "should make new item in cart equal to 1" do
#       expect(@cart[:food_id]).to eq 1
#     end
#   end
#
#   describe "#update_items" do
#     it "should increment the qty of items in cart by 1" do
#       qty = 3
#       @cart.update(qty)
#       expect(@cart[1]).to eq 4
#     end
#   end
#
#
#   describe "#destroy" do
#     it "should empty the cart" do
#       @cart.destroy!
#       expect(@cart).to eq nil
#     end
#
#     it "notifies the user the cart has been deleted" do
#       expect(flash[:notice]).to be_present
#     end
#   end
#
# end

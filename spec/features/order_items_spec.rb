require 'rails_helper'

RSpec.feature "OrderItems", type: :feature do
  scenario "the order_items index page can show all of the food in the cart" do

    food_id = 1
    visit order_items_path

    
  end
end

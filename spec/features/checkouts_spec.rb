require 'rails_helper'

RSpec.feature "Checkouts", type: :feature do
  before(:each) do
  O1 = Order.create(Status: "Completed", total: 23600,
                    vat: 2100, delivery_cost: 500, user_id: 6, 
                    created_at: "2015-10-20 15:49:28",
                    updated_at: "2015-10-20 15:49:28",
                    transaction_id: "1VX775486T314881H",
                    invoice: "", pickup_time: 26)
  
  O2 = Order.create(Status: "Completed", total: 23600, 
                    vat: 2100, delivery_cost: 500,
                    user_id: 6,
                    created_at: "2015-10-20 15:49:28",
                    updated_at: "2015-10-20 15:49:28",
                    transaction_id: "1VX775486T314881H",
                    invoice: "",
                    pickup_time: 26)
  end

  describe "User can check out from Carts page" do
    scenario "user clicks checkout button on carts page" do
      Food.create(name: "coconut rice",
                  description: "tasty coconut rice cooked with shrimps",
                  price: 4000)
      Order.create(Status: "Completed",
                  total: 23600, vat: 2100, delivery_cost: 500,
                  user_id: 6, created_at: "2015-10-20 15:49:28",
                  updated_at: "2015-10-20 15:49:28", transaction_id: "1VX775486T314881H",
                  invoice: "", pickup_time: 26)
      visit foods_path
      click_button "Add to cart"


      visit carts_path

      click_button "Checkout"

      expect(current_path).to eq login_path
    end
  end

  describe "User checks out" do
    scenario "User checkout page contains items from cart" do
      Food.create(name: "coconut rice", 
                  description: "tasty coconut rice cooked with shrimps",
                  price: 4000)
      User.create(first_name: "jeff", 
                  last_name: "Mongo", 
                  email: "seyi@andela.com",
                  password: "seyijeff",
      password_confirmation: "seyijeff")
      visit foods_path
      3.times do
        click_button "Add to cart"
      end

      within "header nav" do
        click_link "cart"
      end

      click_button "Checkout"
      expect(current_path).to eq login_path
      fill_in "session_email", with: 'seyi@andela.com'
      fill_in "session_password", with: 'seyijeff'
      click_button('Log in')
      expect(current_path).to eq carts_path
      click_button "Checkout"
      expect(page).to have_button("Make payment")
      expect(page).to have_content("coconut rice")
      expect(page).to have_content("N12000.0")
    end
  end

  describe "Non logged in user have to login to checkout" do
    scenario "non logged in user should be redirected to login form on checkout attempt" do
      Food.create(name: "coconut rice",
                  description: "tasty coconut rice cooked with shrimps",
                  price: 4000)
      visit foods_path
      click_button "Add to cart"
      visit carts_path
      click_button "Checkout"
      expect(current_path).to eq login_path
    end
  end
end

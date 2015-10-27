require "rails_helper"

RSpec.feature "ProfilePages", type: :feature do
  describe "User clicks My Profile" do
    it "should take user to profile page" do
      @user = User.create(first_name: "Toyosi",
                          last_name: "Famakinde",
                          email: "toyosif@yahoo.com",
                          password: "jeffrules",
                          password_confirmation: "jeffrules")

      visit foods_path
      click_link "Log in"
      within (".login_form") do
        fill_in "session_email", :with => @user.email
        fill_in "session_password", :with => "jeffrules"
        click_button "Log in"
      end
      expect(current_path).to eq(foods_path)

      click_link "My Profile"
      expect(current_path).to eq(user_path(@user.id))

      visit user_path(@user.id)
      expect(page).to have_content "#{@user.first_name}"
      expect(page).to have_content "#{@user.last_name}"
      expect(page).to have_content "#{@user.email}"
      expect(page).to have_link("Edit Profile")
      expect(page).to have_link("View Orders")

      click_link("View Orders")
      expect(page).to have_content "All Orders"
    end
  end

  describe "User clicks On food name on profile page" do
    it "should take user to the food description page" do
      @user = User.create(first_name: "Toyosi",
                          last_name: "Famakinde",
                          email: "toyosif@yahoo.com",
                          password: "jeffrules",
                          password_confirmation: "jeffrules")

      F2 = Food.create(name: "Spagetti bolognese",
                       description: "Warm yummy spagetti to increase your life span!",
                       price: 1500 )

      O1 = Order.create(Status: "Completed", user_id: @user.id, transaction_id: "12XX12", total: "1500" )

      Order_Item1 = OrderItem.create(quantity: 3, food_id: F2.id, order_id: O1.id)

      visit root_path

      click_link "Log in"
      within (".login_form") do
        fill_in "session_email", :with => @user.email
        fill_in "session_password", :with => "jeffrules"
        click_button "Log in"
      end

      expect(current_path).to eq(root_path)

      click_link "My Profile"

      expect(page).to have_link("Spagetti bolognese")

      click_link("Spagetti bolognese")

      expect(current_path).to eq(food_path(F2.id))
    end
  end

end

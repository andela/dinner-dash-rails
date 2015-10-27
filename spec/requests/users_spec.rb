require "rails_helper"

RSpec.feature "Users", type: :feature do
  describe "User clicks sign-up button on home page" do
    scenario "should visit sign up page" do
      visit root_path
      click_link "Sign up"

      expect(current_path).to eq new_user_path
    end
    scenario "page should contain form details" do
      visit new_user_path
      expect(page).to have_content "First name"
      expect(page).to have_content "Last name"
      expect(page).to have_content "Email"
      expect(page).to have_content "Password"
      expect(page).to have_content "Password confirmation"
    end
  end

  describe "On successful user sign up" do
    scenario "should redirect the user to the previous page" do
      visit root_path
      click_link "Sign up"

      page.fill_in "user_first_name", :with => "Daisi"
      page.fill_in "user_last_name", :with => "Sowemimo"
      page.fill_in "user_email", :with => "daisi@som.com"
      page.fill_in "user_password", :with => "Daisinow"
      page.fill_in "user_password_confirmation", :with => "Daisinow"
      click_button "Sign up"
      expect(current_path).to eq root_path
    end
  end

  describe "Unsuccessful user sign up" do
    scenario "should redirect the user to the signup page" do
      visit new_user_path

      page.fill_in "user_first_name", :with => "Daisi"
      page.fill_in "user_last_name", :with => "Sowemimo"
      page.fill_in "user_email", :with => "daisi@som.com"
      page.fill_in "user_password", :with => "Daisi"

      click_button "Sign up"
      expect(current_path).to eq users_path
    end
  end

  describe "Edit profile" do
    scenario "should redirect to edit profile page" do
      user = User.create(first_name: "jeff", last_name: "Mongo", email: "seyi@andela.com", password: "seyijeff",
      password_confirmation: "seyijeff")
      visit foods_path

      click_link "Log in"
      within (".login_form") do
        fill_in "session_email", :with => user.email
        fill_in "session_password", :with => "seyijeff"
        click_button "Log in"
      end

      click_link "My Profile"
      expect(current_path).to eq(user_path(user.id))

      click_link "Edit Profile"
      expect(current_path).to eq edit_user_path(user.id)

      expect(page).to have_selector("input[value='jeff']")
      page.fill_in "user_first_name", :with => "Daisi"
      click_button "Save Changes"

      expect(current_path).to eq(user_path(user.id))
      expect(page).to have_content "Daisi"
    end
  end

  describe "Image Upload" do
    scenario "should show uploaded avatar for user" do
      visit root_path
      click_link "Sign up"

      page.fill_in "user_first_name", :with => "Daisi"
      page.fill_in "user_last_name", :with => "Sowemimo"
      page.fill_in "user_email", :with => "daisi@som.com"
      page.fill_in "user_password", :with => "Daisinow"
      page.fill_in "user_password_confirmation", :with => "Daisinow"
      page.attach_file("user[avatar]", Rails.root +
      "app/assets/images/chicken.jpg")
      click_button "Sign up"
      expect(current_path).to eq root_path
    end
  end
end

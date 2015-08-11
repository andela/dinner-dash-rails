require 'rails_helper'

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
end

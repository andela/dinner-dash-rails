require 'rails_helper'

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
        expect(page).to have_link('Edit Profile')
        expect(page).to have_link('View Orders')
    end
    
  end
end

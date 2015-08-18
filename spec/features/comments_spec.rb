require 'rails_helper'

RSpec.feature "Comments", type: :feature do
  describe "User should see food comments" do
    it "should display food comments on food page" do
      @user = User.create(first_name: "Toyosi", 
                    last_name: "Famakinde", 
                    email: "toyosif@yahoo.com", 
                    password: "jeffrules", 
                    password_confirmation: "jeffrules")
      F1 = Food.create(name: "Spagetti bolognese",
                 description: "Warm yummy spagetti to increase your life span!",
                 price: 1500 )

      Comment1 = Comment.create(comment: "Best food ever", food_id: F1.id, user_id: @user.id)

      visit food_path(F1.id)

      expect(page).to have_content("Best food ever")

    end
  end

  # describe "User can adds comments on food page" do
  #   it "should add comment to the page when user clicks add comment button" do
  #     @user = User.create(first_name: "Toyosi", 
  #                         last_name: "Famakinde", 
  #                         email: "toyosif@yahoo.com", 
  #                         password: "jeffrules", 
  #                         password_confirmation: "jeffrules")

  #     F1 = Food.create(name: "Spagetti bolognese",
  #                      description: "Warm yummy spagetti to increase your life span!",
  #                      price: 1500 )

  #     visit root_path

  #     click_link "Log in"
  #     within (".login_form") do
  #       fill_in "session_email", :with => @user.email
  #       fill_in "session_password", :with => "jeffrules"
  #       click_button "Log in"
  #     end

  #     visit food_path(F1.id)

  #     expect(current_path).to eq(food_path(F1.id))

  #     fill_in "comment[comment]", :with => "Best food ever"

  #     click_button "Add comment"

  #     expect(page).to have_content("Best food ever")

  #   end
  # end 
end

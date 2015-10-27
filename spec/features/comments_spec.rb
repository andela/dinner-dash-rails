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
end

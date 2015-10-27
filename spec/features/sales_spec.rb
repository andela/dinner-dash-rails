require "rails_helper"

RSpec.feature "UserAddItemsToCarts", type: :feature do
  describe "add food to sale" do
    scenario "admin add a food to sales" do
      food = create(:food)
      admin = create(:admin)
      visit root_path
      click_link("Log in")
      fill_in "session_email", with: admin.email
      fill_in "session_password", with: admin.password
      click_button("Log in")
      visit new_sale_path
      expect(page).to have_content(food.name)
    end
  end
end

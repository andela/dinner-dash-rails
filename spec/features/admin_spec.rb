require "rails_helper"

RSpec.feature "Update Order Status", type: :feature do
  describe "update the status of an order" do
    scenario "admin updates the status of an order" do
      create(:order)
      admin = create(:admin)
      visit root_path
      click_link("Log in")
      fill_in "session_email", with: admin.email
      fill_in "session_password", with: "andela"
      click_button("Log in")
      visit dashboard_path
      select("Cancelled", from: "order[Status]")
      click_button("Confirm")
      expect(current_path).to eq dashboard_path
      expect(page).to have_content("Cancelled")
    end
  end
end

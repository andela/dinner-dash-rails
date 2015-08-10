require "rails_helper"

RSpec.feature "UserAddItemsToCarts", type: :feature do
  before(:each) do
    Food.create(
      name: "Spagetti bolognese",
      description: "Warm yummy spagetti to increase your life span!",
      price: 1500
    )
  end

  describe "add items to cart" do
    scenario "user adds first item to cart" do
      visit foods_path
      expect(page).to have_css("#cart", text: "0")
      click_button "Add to cart"
      expect(page).to have_css("#cart", text: "1")
    end

    scenario "user chooses to add the same item again" do
      visit foods_path
      3.times do
        click_button "Add to cart"
      end
      expect(page).to have_css("#cart", text: "3")
    end
  end
end

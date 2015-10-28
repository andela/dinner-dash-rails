require "rails_helper"

RSpec.feature "UserAddItemsToCarts", type: :feature do
  before(:each) do
    F1 = Food.create(
      name: "Spagetti bolognese",
      description: "Warm yummy spagetti to increase your life span!",
      price: 1500,
      prep_time: 12)
    O1 = Order.create(Status: "Completed", total: 236,
                      vat: 2100, delivery_cost: 500, user_id: 6,
                      created_at: "2015-10-20 15:49:28",
                      updated_at: "2015-10-20 15:49:28",
                      transaction_id: "1VX775486T314881H",
                      invoice: "", pickup_time: 26)
  end
  describe "add items to cart" do
    scenario "user adds first item to cart" do
      visit foods_path
      expect(page).to have_css("#cart", text: "0")
      click_button "Add to cart"
      expect(page).to have_css("#cart", text: "1")
      3.times do
        click_button "Add to cart"
      end
      expect(page).to have_css("#cart", text: "4")
      visit carts_path
      expect(page).to have_content("#{F1.name}")
      expect(page).to have_content("#{F1.price}")
      expect(page).to have_css(".line-total", text: "6000")
      expect(page).to have_css("#total", text: "6000")
      expect(page).to have_css("#prep_total",
                               text: "Your food will be ready in 16 minutes MAX")
    end
  end
end

require "rails_helper"
RSpec.feature "Foods", type: :feature do
  scenario "the food index page shows all the food" do
    Food.create(
      name: "Spaghetti",
      description: "Best spaghetti ever",
      price: 1500.00
    )
    Food.create(
      name: "Jollof rice",
      description: "Hot spicy jollof ever",
      price: 1600.00
    )
    visit foods_path
    expect(page).to have_content("Jollof rice")
    expect(page).to have_content("Spaghetti")
  end
end

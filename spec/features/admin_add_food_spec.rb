require "rails_helper"
RSpec.feature "Foods", type: :feature do
  before(:each) do
    @user = User.create(first_name: "Toyosi",
                        last_name: "Famakinde",
                        email: "toyosif@yahoo.com",
                        password: "jeffrules",
                        password_confirmation: "jeffrules",
                        role: "admin")

    Category.create(title: "Entree", description: "first meal")
    @F1 = Food.create(name: "Spaghetti",
                      description: "Best spaghetti ever",
                      price: 1500.00 )
    visit root_path
    click_link('Log in')
    expect(current_path).to eq(login_path)
    expect(page).to have_selector("h3", text: "Log in")
    fill_in "session_email", with: 'toyosif@yahoo.com'
    fill_in "session_password", with: 'jeffrules'
    click_button('Log in')
  end

  scenario "the food index page shows all the food" do
    visit foods_path
    expect(page).to have_content("Spaghetti")
  end

  scenario "admin should be able to add new food" do
    expect(current_path).to eq("/admin")
    visit("foods/new")
    expect(page).to have_content("Create new food")

      page.fill_in "food_name", :with => "Pancake n Syrup"
      page.fill_in "food_description", 
                    :with => "Juicy syrup on fresh home-baked pancakes"
      page.fill_in "food_price", :with => 100
      page.fill_in "food_prep_time", :with => 12
      select('Entree', from: 'food_category_id')
      page.attach_file('food[food_image]', Rails.root + 'app/assets/images/chicken.jpg')
      click_button "Add food"
      expect(current_path).to eq admin_foods_path
     expect(page).to have_content("Pancake n Syrup")
  end

  scenario "admin should edit food" do
    visit(admin_foods_path)
    click_link("Spaghetti")
    expect(current_path).to eq edit_food_path(@F1.id)
    page.fill_in "food_name", :with => "Pancake and meatballs"
    page.attach_file('food[food_image]', Rails.root + 'app/assets/images/chicken.jpg')
    click_button "Add food"
    expect(current_path).to eq admin_foods_path
    expect(page).to have_content("Pancake and meatballs")
  end

  scenario "admin should delete food" do
    visit(admin_foods_path)
    click_button "clear"
    expect(current_path).to eq admin_foods_path
    expect(page).to_not have_content("Spaghetti")
  end

end






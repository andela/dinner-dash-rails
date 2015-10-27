require "rails_helper"

RSpec.feature "Sessions", type: :feature do
  scenario "login page can show the log in form" do
    visit login_path
    expect(page).to have_selector("h3", text: "Log in")
  end

  scenario "log in with valid details and redirect to foods page" do
    User.create(first_name: "jeff", last_name: "Mongo", email: "seyi@andela.com", password: "seyijeff",
      password_confirmation: "seyijeff")
    visit foods_path
    click_link("Log in")
    expect(current_path).to eq(login_path)
    expect(page).to have_selector("h3", text: "Log in")
    fill_in "session_email", with: "seyi@andela.com"
    fill_in "session_password", with: "seyijeff"
    click_button("Log in")
    expect(current_path).to eq(foods_path)
  end

  scenario "redirect admin to dashboard path on log in" do
    @user = create(:admin)
    visit root_path
    click_link("Log in")
    fill_in "session_email", with: "admin@andela.com"
    fill_in "session_password", with: "andela"
    click_button("Log in")
    expect(current_path).to eq(dashboard_path)
  end

  scenario "log out a user" do
    @user = create(:user)
    visit root_path
    click_link("Log in")
    fill_in "session_email", with: "seyi@andela.com"
    fill_in "session_password", with: "seyijeff"
    click_button("Log in")
    click_link("Log out")
    expect(current_path).to eq(foods_path)
  end
end

require 'rails_helper'

RSpec.feature "Sessions", type: :feature do
  scenario "login page can show the log in form" do
    visit login_path
    expect(page).to have_selector("h1", text: "Log in")
  end

  scenario "log in with valid details and redirect to foods page" do
    User.create(first_name: "jeff", last_name: "Mongo", email: "seyi@andela.com", password: "seyi", 
      password_confirmation: "seyi")
    visit foods_path
    click_link('Log in')
    expect(current_path).to eq(login_path)
    expect(page).to have_selector("h1", text: "Log in")
    fill_in "session_email", with: 'seyi@andela.com'
    fill_in "session_password", with: 'seyi'
    click_button('Log in')
    expect(current_path).to eq(foods_path)
  end
end

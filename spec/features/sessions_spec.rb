require 'rails_helper'

RSpec.feature "Sessions", type: :feature do
  scenario "login page can show the log in form" do
    visit login_path
    expect(page).to have_selector("h1", text: "Log in")
  end
end

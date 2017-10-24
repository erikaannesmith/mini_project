require 'rails_helper'

describe "User can create a new designer account" do
  scenario "user visits root page" do
    visit "/"

    expect(page).to have_button("Log In")
    expect(page).to have_field("session[email]")
    expect(page).to have_field("session[password]")

    click_on "Register"

    expect(current_path).to eq(new_user_path)

    expect(page).to have_content("Register:")
    expect(page).to have_field("user[email]")
    expect(page).to have_field("user[password]")
    expect(page).to have_field("user[company_name]")
    expect(page).to have_field("user[location]")
    expect(page).to have_field("user[website]")
  end

  scenario "user creates an account" do
    visit "/"

    click_on "Register"

    fill_in "user[email]", with: "test@test.com"
    fill_in "user[password]", with: "test"
    fill_in "user[company_name]", with: "test"
    fill_in "user[location]", with: "test"
    fill_in "user[website]", with: "www.test.com"

    click_on "Submit"

    expect(current_path).to eq(user_path(User.last.id))
  end

  scenario "user logs into their account" do
    user = User.create(email: "x", password: "x", location: "x", company_name:"x", website: "x")

    visit "/"

    expect(page).to have_field("session[email]")
    expect(page).to have_field("session[password]")


    fill_in "session[email]", with: "x"
    fill_in "session[password]", with: "x"

    click_button "Log In"

    expect(current_path).to eq(user_path(user))
  end
end

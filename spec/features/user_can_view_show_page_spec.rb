require 'rails_helper'

describe "User can view their show page as dashboard" do
  before :each do
    @user = User.create(email: "x", password: "x", location: "x", company_name:"x", website: "x")

    visit "/"

    expect(page).to have_field("session[email]")
    expect(page).to have_field("session[password]")


    fill_in "session[email]", with: "x"
    fill_in "session[password]", with: "x"

    click_button "Log In"
  end

  it "shows a link to the users portfolio on dashboard" do
    @user.designs.create(name: "hi")
    @user.designs.create(name: "123")

    expect(page).to have_link("Portfolio")

    click_link "Portfolio"

    expect(current_path).to eq(user_designs_path(@user))

    expect(page).to have_content("hi")
    expect(page).to have_content("123")
    expect(@user.designs.count).to eq(2)
  end
end

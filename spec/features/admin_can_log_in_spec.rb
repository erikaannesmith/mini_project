require 'rails_helper'

RSpec.describe "Users can log in as admin" do 
    before :each do 
        @admin_user = User.create(email: "Lola@allsaints.com",
                                password: "password",
                                company_name: "All Saints",
                                website: "www.allsaints.com",
                                location: "London",
                                role: 1)

        allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(@admin_user)
    end

    scenario "admin sees a form at login" do
        visit "/"

        expect(current_path).to eq(root_path)
        expect(page).to have_content("Log In:")
        expect(page).to have_field("session[email]")
        expect(page).to have_field("session[password]")
    end

    scenario "admin logs in" do
        visit root_path
        fill_in "session[email]", with: "x"
        fill_in "session[password]", with: "p"

        click_on "Log In"

        expect(current_path).to eq(root_path)
    end

    scenario "admin logs in" do
        visit root_path
        fill_in "session[email]", with: "Lola@allsaints.com"
        fill_in "session[password]", with: "password"

        click_on "Log In"

        expect(current_path).to eq(admin_dashboard_index_path)
        expect(page).to have_content("Welcome, #{@admin_user.email}!")
        expect(page).to have_link("All Partnerships")
        expect(page).to have_link("All Contacts")
        expect(page).to have_link("All Designers")
        expect(page).to have_link("Log Out")
    end

    scenario "admin clicks on partnerships to see all partnerships" do
        visit root_path
        fill_in "session[email]", with: "Lola@allsaints.com"
        fill_in "session[password]", with: "password"

        click_on "Log In"

        expect(current_path).to eq(admin_dashboard_index_path)

        click_on "All Partnerships"

        expect(current_path).to eq(admin_partnerships_path)
        expect(page).to have_content
    end




end

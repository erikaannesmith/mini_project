require 'rails_helper'

RSpec.describe "Users can log in as admin" do 
    before :each do 
        @admin_user = User.create(email: "Lola@allsaints.com",
                                password: "password",
                                company_name: "All Saints",
                                website: "www.allsaints.com",
                                location: "London",
                                role: 1)
        @user = User.create(email: "abc",
                        password: "123",
                        company_name: "Yas",
                        website: "www.yas.com",
                        location: "YASland")
        @contact = Contact.create(company: "LuluLemon",
                               contact_name: "Cindy",
                               location: "New York",
                               phone_number: "4044044404",
                               email: "cindy@lululemon.com",
                               industry: "Retailer")

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

        partnership = Partnership.create!(user: @user, contact: @contact)

        click_on "All Partnerships"

        expect(current_path).to eq(admin_partnerships_path)
        expect(page).to have_content("#{partnership.user.company_name} and #{partnership.contact.company}")
        expect(page).to have_link("Dashboard")
        expect(page).to have_link("All Contacts")
        expect(page).to have_link("All Designers")
        expect(page).to have_link("Log Out")
    end




end

require 'rails_helper'

RSpec.describe "admin authorization" do 
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

        click_on "#{partnership.user.company_name}"

        expect(current_path).to eq(admin_user_path(partnership.user))
        expect(page).to have_link("Dashboard")
        expect(page).to have_link("All Partnerships")
        expect(page).to have_link("All Contacts")
        expect(page).to have_link("All Designers")
        expect(page).to have_link("Log Out")

        click_on "All Partnerships"

        expect(current_path).to eq(admin_partnerships_path)

        click_on "#{partnership.contact.company}"

        expect(current_path).to eq(admin_contact_path(partnership.contact))
        expect(page).to have_link("Dashboard")
        expect(page).to have_link("Edit")
        expect(page).to have_link("All Partnerships")
        expect(page).to have_link("All Contacts")
        expect(page).to have_link("All Designers")
        expect(page).to have_link("Log Out")

        click_on "Edit"

        fill_in "contact[contact_name]", with: "Sarah"

        click_on "Update Contact"

        expect(current_path).to eq(admin_contact_path(partnership.contact))
    end

    scenario "admin clicks on all contacts" do
        visit admin_contacts_path

        expect(page).to have_link("Cindy @ LuluLemon")
        expect(page).to have_link("Edit")
        expect(page).to have_link("New Contact")
        expect(page).to have_link("Delete")
        expect(page).to have_link("Dashboard")
        expect(page).to have_link("All Partnerships")
        expect(page).to have_link("All Designers")
        expect(page).to have_link("Log Out")

        click_on "Delete"

        expect(current_path).to eq(admin_contacts_path)
        expect(page).not_to have_content("Cindy @ LuluLemon")
    end

    scenario "admin can create a contact" do
        visit admin_contacts_path

        click_on "New Contact"

        expect(current_path).to eq(new_admin_contact_path)
        expect(page).to have_link("Dashboard")
        expect(page).to have_link("All Partnerships")
        expect(page).to have_link("All Contacts")
        expect(page).to have_link("All Designers")
        expect(page).to have_link("Log Out")

        fill_in "contact[company]", with: "a"
        fill_in "contact[contact_name]", with: "b"
        fill_in "contact[location]", with: "c"
        fill_in "contact[email]", with: "d"
        fill_in "contact[phone_number]", with: "e"
        click_on "Create Contact"

        expect(current_path).to eq(admin_contacts_path)
        expect(page).to have_content("b @ a")
        expect(page).to have_link("Dashboard")
        expect(page).to have_link("All Partnerships")
        expect(page).to have_link("All Designers")
        expect(page).to have_link("Log Out")

        click_on "b @ a"

        new_contact = Contact.find_by(company: "a")

        expect(current_path).to eq(admin_contact_path(new_contact))
    end

    scenario "admin can see all designers" do
        visit admin_users_path

        expect(page).to have_content("All Designers:")
        expect(page).to have_link("Dashboard")
        expect(page).to have_link("All Partnerships")
        expect(page).to have_link("All Contacts")
        expect(page).to have_link("Log Out")
        expect(page).to have_link("abc @ Yas")

        click_on "abc @ Yas"

        expect(current_path).to eq(admin_user_path(@user))
        expect(page).to have_link("Dashboard")
        expect(page).to have_link("All Partnerships")
        expect(page).to have_link("All Designers")
        expect(page).to have_link("All Contacts")
        expect(page).to have_link("Log Out")
    end
    
    scenario "admin can log out" do
        visit admin_users_path

        click_on "Log Out"

        expect(current_path).to eq(root_path)
        expect(:current_user).not_to eq(@admin_user)
    end
end

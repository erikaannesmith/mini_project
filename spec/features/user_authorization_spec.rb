require 'rails_helper'

describe "user authorization" do
    before :each do
        @user = User.create(email: "abc",
                        password: "123",
                        company_name: "Yas",
                        website: "www.yas.com",
                        location: "YASland")
    end
    
    scenario "user can log in" do
        visit "/"

        expect(current_path).to eq(root_path)
        expect(page).to have_content("Log In:")
        expect(page).to have_field("session[email]")
        expect(page).to have_field("session[password]")
        
        fill_in "session[email]", with: "abc"
        fill_in "session[password]", with: "123"

        click_on "Log In"

        expect(current_path).to eq(user_dashboard_index_path(@user))
        expect(page).to have_content("Welcome, #{@user.email}!")
        expect(page).to have_link("Portfolio")
        expect(page).to have_link("Contacts")
        expect(page).to have_link("Log Out")
    end

    scenario "user can see all designs in portfolio" do
        allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(@user)
        design = @user.designs.create(name: "Pleated Skirt", description: "xyz")
        visit user_designs_path(@user)

        expect(page).to have_content("All Designs:")
        expect(page).to have_link(design.name)
        expect(page).to have_link("New Design")
        expect(page).to have_link("Dashboard")
        expect(page).to have_link("Contacts")
        expect(page).to have_link("Log Out")

        click_on "New Design"

        expect(current_path).to eq(new_user_design_path(@user))
    end

    scenario "user can create a new design via form" do
        allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(@user)        
        visit new_user_design_path(@user)

        expect(page).to have_content("New Design")
        expect(page).to have_field("design[name]")
        expect(page).to have_field("design[description]")
        expect(page).to have_link("Dashboard")
        expect(page).to have_link("Portfolio")
        expect(page).to have_link("Contacts")
        expect(page).to have_link("Log Out")

        fill_in "design[name]", with: "Pants"
        fill_in "design[description]", with: "yup"

        click_on "Create Design"

        expect(current_path).to eq(user_designs_path(@user))
        expect(page).to have_link("Pants")
    end

    scenario "user can see all contacts" do
        allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(@user)      
        contact = @user.contacts.create(company: "LuluLemon",
                                        contact_name: "Cindy",
                                        location: "New York",
                                        phone_number: "4044044404",
                                        email: "cindy@lululemon.com",
                                        industry: "Retailer")
        user2 = User.create(email: "x",
                            password: "x",
                            company_name: "x",
                            website: "x",
                            location: "x")
        contact2 = user2.contacts.create(company: "y",
                                        contact_name: "y",
                                        location: "y",
                                        phone_number: "y",
                                        email: "y",
                                        industry: "y")
        visit user_dashboard_index_path(@user)

        click_on "Contacts"

        expect(current_path).to eq(user_partnerships_path(@user))
        expect(page).to have_content("Cindy @ LuluLemon")
        expect(page).to have_link("Dashboard")
        expect(page).to have_link("Portfolio")
        expect(page).to have_link("Log Out")

        click_on "Cindy @ LuluLemon"

        expect(current_path).to eq(user_contact_path(@user, contact))
        expect(page).to have_content("LuluLemon")
        expect(page).to have_link("Dashboard")
        expect(page).to have_link("Portfolio")
        expect(page).to have_link("Contacts")
        expect(page).to have_link("Log Out")
    end

    scenario "user can delete a partnership" do
        allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(@user)      
        contact = Contact.create(company: "x", 
                       contact_name: "x",
                       location: "x",
                       email: "x",
                       phone_number: "x",
                       industry: "Manufacturer")
        partnership = @user.partnerships.create(contact: contact)

        visit user_partnerships_path(@user)

        expect(page).to have_link("x @ x")
        expect(@user.partnerships.count).to eq(1)
        expect(page).to have_link("Delete")

        click_on "Delete"

        expect(@user.partnerships.count).to eq(0)        
    end

    scenario "user can view the contact show page" do
        allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(@user)      
        contact = Contact.create(company: "x", 
                       contact_name: "x",
                       location: "x",
                       email: "x",
                       phone_number: "x",
                       industry: "Manufacturer")
        partnership = @user.partnerships.create(contact: contact)

        visit user_partnerships_path(@user)

        click_on "x @ x"

        expect(current_path).to eq(user_contact_path(@user, contact))
        expect(page).to have_link("Dashboard")
        expect(page).to have_link("Contacts")
        expect(page).to have_link("Portfolio")
        expect(page).to have_link("Log Out")

        click_on "Log Out"

        expect(current_path).to eq(root_path)
        expect(:current_user).not_to eq(@user)
    end
end
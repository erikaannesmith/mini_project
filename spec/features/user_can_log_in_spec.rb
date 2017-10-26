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
    end
end
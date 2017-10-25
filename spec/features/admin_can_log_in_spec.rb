require 'rails_helper'

RSpec.describe "Users can log in as admin" do 
    # before :each do 
    #     admin_user = User.create(email: "Lola@allsaints.com",
    #                             password: "password",
    #                             company_name: "All Saints",
    #                             website: "www.allsaints.com",
    #                             location: "London",
    #                             role: 1)

    # # allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(admin_user)
    # end

    scenario "admin sees a form at login" do
        visit "/"

        expect(current_path).to eq(root_path)
        expect(page).to have_content("Log In:")
        expect(page).to have_field("session[email]")
        expect(page).to have_field("session[password]")
    end


end

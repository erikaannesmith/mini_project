require 'rails_helper'

RSpec.describe "When user visits admin contacts index" do 
    describe "as an admin" do
        it "I see a list of contacts" do 
            admin_user = User.create(email: "Lola@allsaints.com",
                                     password: "password",
                                     company_name: "All Saints",
                                     website: "www.allsaints.com",
                                     location: "London",
                                     role: 1)

            allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(admin_user)

            visit admin_contacts_path

            expect(page).to have_content("Contacts")
        end
    end

    describe "as a default user" do
        it "I see a 404" do 
            default_user = User.create(email: "Lola@allsaints.com",
                                       password: "password",
                                       company_name: "All Saints",
                                       website: "www.allsaints.com",
                                       location: "London")

            allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(default_user)

            visit admin_contacts_path

            expect(status_code).to eq(404)
        end
    end
end
require 'rails_helper'

describe Partnership do
    before :each do
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
    end
    describe "validations" do
        context "invalid attributes" do
            it "is invalid without a user" do
                partnership = Partnership.new(contact: @contact)

                expect(partnership).to be_invalid
            end

            it "is invalid without a contact" do
                partnership = Partnership.new(user: @user)

                expect(partnership).to be_invalid
            end
        end

        context "valid attributes" do
            it "is valid with a user and contact" do
                partnership = Partnership.new(user: @user, 
                                              contact: @contact)
                                            
                expect(partnership).to be_valid                 
            end
        end
    end
end
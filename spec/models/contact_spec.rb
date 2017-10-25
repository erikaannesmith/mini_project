require 'rails_helper'

RSpec.describe Contact, type: :model do
  describe "Validations" do
    context "invalid attributes" do
      it "is invalid without a company" do 
        contact = Contact.create(contact_name: "Cindy",
                                 location: "New York",
                                 phone_number: "4044044404",
                                 email: "cindy@lululemon.com",
                                 industry: "Retailer")
                                  
        expect(contact).to be_invalid
      end

      it "is invalid without contact name" do 
        contact = Contact.create(company: "LuluLemon",
                                 location: "New York",
                                 phone_number: "4044044404",
                                 email: "cindy@lululemon.com",
                                 industry: "Retailer")
                                  
        expect(contact).to be_invalid
      end
    
      it "is invalid without location" do 
        contact = Contact.create(company: "LuluLemon",
                                 contact_name: "Cindy",
                                 phone_number: "4044044404",
                                 email: "cindy@lululemon.com",
                                 industry: "Retailer")
                                  
        expect(contact).to be_invalid
      end

      it "is invalid without phone number" do 
        contact = Contact.create(company: "LuluLemon",
                                 contact_name: "Cindy",
                                 location: "New York",
                                 email: "cindy@lululemon.com",
                                 industry: "Retailer")
                                  
        expect(contact).to be_invalid
      end

      it "is invalid without email" do 
        contact = Contact.create(company: "LuluLemon",
                                 contact_name: "Cindy",
                                 location: "New York",
                                 phone_number: "4044044404",
                                 industry: "Retailer")
                                  
        expect(contact).to be_invalid
      end

      it "is invalid without an industry" do 
        contact = Contact.create(company: "LuluLemon",
                                 contact_name: "Cindy",
                                 location: "New York",
                                 phone_number: "4044044404",
                                 email: "cindy@lululemon.com")
                                  
        expect(contact).to be_invalid
      end
    end

    context "valid attributes" do
      it "is valid with a company, contact name, location, phone number, email, and industry" do
        contact = Contact.create(company: "LuluLemon",
                                 contact_name: "Cindy",
                                 location: "New York",
                                 phone_number: "4044044404",
                                 email: "cindy@lululemon.com",
                                 industry: "Retailer")

        expect(contact).to be_valid
      end
    end
  end

  describe "Relationships" do
    it "has many users" do 
      contact = Contact.create(company: "LuluLemon",
                               contact_name: "Cindy",
                               location: "New York",
                               phone_number: "4044044404",
                               email: "cindy@lululemon.com",
                               industry: "Retailer")

      expect(contact).to respond_to(:users)
    end

    it "but only through partnerships" do 
      contact = Contact.create(company: "LuluLemon",
                               contact_name: "Cindy",
                               location: "New York",
                               phone_number: "4044044404",
                               email: "cindy@lululemon.com",
                               industry: "Retailer")

      expect(contact).to respond_to(:partnerships)
    end
  end
end

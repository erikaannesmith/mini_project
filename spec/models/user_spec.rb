require 'rails_helper'

describe User do
  describe "validations" do
    context "invalid attributes" do
      it "is invalid without email" do
        user = User.create(password: "123",
                        company_name: "Yas",
                        website: "www.yas.com",
                        location: "YASland")

        expect(user).to be_invalid
      end

      it "is invalid without password" do
        user = User.create(email: "abc",
                        company_name: "Yas",
                        website: "www.yas.com",
                        location: "YASland")

        expect(user).to be_invalid
      end

      it "is invalid without company_name" do
        user = User.create(email: "abc",
                        password: "123",
                        website: "www.yas.com",
                        location: "YASland")

        expect(user).to be_invalid
      end

      it "is invalid without website" do
        user = User.create(email: "abc",
                        password: "123",
                        company_name: "Yas",
                        location: "YASland")

        expect(user).to be_invalid
      end

      it "is invalid without location" do
        user = User.create(email: "abc",
                        password: "123",
                        company_name: "Yas",
                        website: "www.yas.com")

        expect(user).to be_invalid
      end
    end
    
    context "valid attributes" do
      it "is valid with email, password, company_name, website, role, and location" do
        user = User.create(email: "abc",
                        password: "123",
                        company_name: "Yas",
                        website: "www.yas.com",
                        location: "YASland")

        expect(user).to be_valid
      end
    end
  end

  describe "relationships" do
    it "has many contacts" do
        user = User.create(email: "abc",
                        password: "123",
                        company_name: "Yas",
                        website: "www.yas.com",
                        location: "YASland")

        expect(user).to respond_to(:contacts)
    end
  end
end

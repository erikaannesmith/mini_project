require 'rails_helper'

describe User do
  describe "validations" do
    context "invalid attributes" do
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
end

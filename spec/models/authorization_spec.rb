require 'rails_helper'

describe User do
    it "they are created as a default user" do
        user = User.create(email: "abc",
                           password: "123",
                           company_name: "Yas",
                           website: "www.yas.com",
                           location: "YASland")

        expect(user).to be_valid
        expect(user.role).to eq("default")
    end

    it "they can be created as a default user" do
        user = User.create(email: "abc",
                           password: "123",
                           company_name: "Yas",
                           website: "www.yas.com",
                           location: "YASland",
                           role: 0)

        expect(user).to be_valid
        expect(user.role).to eq("default")
    end

    it "they are created as an admin user" do
        user = User.create(email: "abc",
                           password: "123",
                           company_name: "Yas",
                           website: "www.yas.com",
                           location: "YASland",
                           role: 1)

        expect(user).to be_valid
        expect(user.role).to eq("admin")

        user.default!

        expect(user.default?).to be_truthy
    end

end

require 'rails_helper'

describe User do
    it "they are created as a default user" do
        user = User.create(email: "abc",
                           password: "123",
                           company_name: "Yas",
                           website: "www.yas.com",
                           location: "YASland",
                           role: 0)
                           
        expect(user).to be_valid
        expect(user.role).to eq("default")
    end
end

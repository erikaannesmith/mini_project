require 'rails_helper'

RSpec.describe Contact, type: :model do
  contact = Contact.create(company: "LuluLemon",
                            contact_name: "Cindy",
                            location: "New York",
                            phone_number: "4044044404",
                            email: "cindy@lululemon.com",
                            industry: "Retailer")

end

require 'rails_helper'

RSpec.describe Design do 
    before :each do
        @user = User.create(password: "password",
                            company_name: "Van Cleef & Arpels",
                            website: "www.vancleefandarpels.com",
                            location: "Paris, France")
    end

    describe 'Validations' do 
        context 'invalid attributes' do 
            it 'is invalid without a name' do 
                design = Design.create(user: @user,
                                        description: "Ruby jewel encrusted, mystery set clutch")

                expect(design).to be_invalid
            end

            it 'is invalid without a designer user' do 
                design = Design.create(name: "Ruby clutch",
                                        description: "Ruby jewel encrusted, mystery set clutch")

                expect(design).to be_invalid
            end

            it 'is invalid without a description' do 
                design = Design.create(name: "Ruby clutch",
                                        user: @user)

                expect(design).to be_invalid
            end
        end

        context 'valid attributes' do 
            it 'is valid with a name, designer user, and description' do 
                design = Design.create(name: "Ruby clutch",
                                        user: @user,
                                        description: "Ruby jewel encrusted, mystery set clutch")

                expect(design).to be_valid                
            end
        end
    end

    describe 'Relationships' do
        it 'belongs to a designer' do
            design = Design.create(name: "Ruby clutch",
                                    user: @user,
                                    description: "Ruby jewel encrusted, mystery set clutch")

            expect(design).to respond_to(:user)
        end

        it 'has many images' do
            design = Design.create(name: "Ruby clutch",
                                    user: @user,
                                    description: "Ruby jewel encrusted, mystery set clutch")

            expect(design).to respond_to(:images)
        end
    end
end
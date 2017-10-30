require 'rails_helper'

RSpec.describe Image do
    before :each do 
        user = User.create(password: "password",
                           company_name: "Van Cleef & Arpels",
                           website: "www.vancleefandarpels.com",
                           location: "Paris, France")
        @design = Design.create(name: "Ruby clutch",
                                user: user,
                                description: "Ruby jewel encrusted, mystery set clutch")
    end

    describe "Validations" do
        context "invalid attributes" do 
            it "is invalid without a design" do 
                image = Image.create(image_file_name: "1158498.jpg", 
                                    image_content_type: "image/jpeg", 
                                    image_file_size: 346843)

                expect(image).to be_invalid
            end

            it "is invalid without an image file name" do 
                image = Image.create(design: @design,
                                    image_content_type: "image/jpeg", 
                                    image_file_size: 346843)

                expect(image).to be_invalid
            end

            it "is invalid without an image content type" do 
                image = Image.create(design: @design,
                                    image_file_name: "1158498.jpg", 
                                    image_file_size: 346843)

                expect(image).to be_invalid
            end

            it "is invalid without an image file size" do 
                image = Image.create(design: @design,
                                    image_file_name: "1158498.jpg", 
                                    image_content_type: "image/jpeg")

                expect(image).to be_invalid
            end
        end
        
        context "valid attributes" do 
            it "is valid with a design, image file name, content type, and size" do    
                image = Image.create(design: @design,
                                    image_file_name: "1158498.jpg", 
                                    image_content_type: "image/jpeg", 
                                    image_file_size: 346843)

                expect(image).to be_valid
            end
        end
    end

    describe "Relationships" do 
        it "belongs to a design" do 
            image = Image.create(design: @design,
                                image_file_name: "1158498.jpg", 
                                image_content_type: "image/jpeg", 
                                image_file_size: 346843)
            
            expect(image).to respond_to(:design)
        end
    end
end
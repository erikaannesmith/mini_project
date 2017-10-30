class ImagesController < ApplicationController
    def new
        @design = Design.find(params[:design_id])
        @image = @design.images.new
        @images = @design.images.all
    end

    def show
        @image = Image.find(params[:id])
    end
    
    def create
        @design = Design.find(params[:design_id])
        @image = @design.images.new(image_params)
        if @image.save
            flash[:success] = "Successfully uploaded new image!"
            redirect_to user_design_path(current_user, @design)
        else
            render :new
        end
    end

    def destroy
        @image = Image.find(params[:id])
        @image.destroy
        flash[:success] = "Image deleted!"

        redirect_to user_design_path(current_user, @image.design)
    end

    private

    def image_params
        params.require(:image).permit(:image)
    end
end

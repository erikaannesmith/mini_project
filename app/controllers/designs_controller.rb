class DesignsController < ApplicationController

  def index
    @designs = current_user.designs
  end

  def show
    @design = current_user.designs.find(params[:id])
    @images = @design.images.all
  end

  def new
    @design = Design.new
  end

  def create
    @design = current_user.designs.new(design_params)
    if @design.save
      flash[:success] = "Successfully created #{@design.name}!"
      redirect_to user_designs_path(current_user)
    else
      render :new
    end
  end

  def edit
    @design = Design.find(params[:id])
  end

  def update
    @design = Design.find(params[:id])
    @design.update(design_params)
    if @design.save
      flash[:success] = "#{@design.name} has been updated!"
      redirect_to user_design_path(current_user, @design)
    else
      render :edit
    end
  end

  def destroy
    @design = Design.find(params[:id])
    @design.destroy
    flash[:success] = "#{@design.name} has been deleted!"
    redirect_to user_designs_path(current_user)
  end

  private

  def design_params
    params.require(:design).permit(:name, :description)
  end

end

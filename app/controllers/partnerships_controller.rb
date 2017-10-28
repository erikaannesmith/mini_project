class PartnershipsController < ApplicationController


  def index
    @partnerships = current_user.partnerships
    @partnership = Partnership.new
  end

  def new
  end

  def create
    @user = User.find(current_user.id)
    @partnership = @user.partnerships.create(user: current_user, contact_id: partnership_params[:contact_id])
    redirect_to user_partnerships_path(@user)
  end

  def destroy
    @partnership = current_user.partnerships.find(params[:id])
    @partnership.destroy
    redirect_to user_partnerships_path(current_user)
  end

  private

  def partnership_params
    params.require(:partnership).permit(:user_id, :contact_id)
  end
  
end

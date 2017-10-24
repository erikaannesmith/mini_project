class PartnershipsController < ApplicationController

  def new
  end

  def create
    @user = User.find(current_user.id)
    @partnership = @user.partnerships.create(partnership_params)
    # params[:partnership] DOESNT have a user_id
    redirect_to user_contacts_path(@user)
  end

  private

  def partnership_params
    params.require(:partnership).permit(:contact_id)
  end

end

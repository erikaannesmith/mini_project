class Admin::UsersController < Admin::BaseController

    def index
        @users = User.where(role: "default")
    end

    def show
        @user = User.find(params[:id])
    end

    def destroy
        @user = User.find(params[:id])
        @user.destroy
        redirect_to admin_users_path
    end

end
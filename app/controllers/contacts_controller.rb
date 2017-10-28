class ContactsController < ApplicationController
    def index
            @user = current_user
            @user_contacts = @user.contacts
            @partnerships = @user.partnerships
    end

    def show
        @contact = Contact.find(params[:id])
    end

    def create
        @partnership = Partnership.create(partnership_params)
    end

    private

    def contact_params
        params.require(:contact).permit(:company, :contact_name, :location, :phone_number, :email, :industry)
    end

    def partnership_params
        params.require(:partnership).permit(current_user, :contact)
    end


end

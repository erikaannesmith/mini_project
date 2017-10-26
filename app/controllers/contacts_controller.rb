class ContactsController < ApplicationController
    def index
            @user = current_user
            @user_contacts = @user.contacts
            @partnership = Partnership.new
    end

    def show
        @contact = Contact.find(params[:id])
    end

    private

    def contact_params
        params.require(:contact).permit(:company, :contact_name, :location, :phone_number, :email, :industry)
    end

end

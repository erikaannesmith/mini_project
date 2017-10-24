class ContactsController < ApplicationController
    def index
        @contacts = Contact.all
    end

    def show
        @contact = Contact.find(params[:id])
    end

    def new
        @contact = Contact.new
    end

    def create
        @contact = Contact.new(contact_params)
        if @contact.save
            flash[:success] = "Success"
            redirect_to contacts_path
        else
            render :new
        end
    end

    def edit

    end

    def update

    end

    def destroy

    end

    private

    def contact_params
        params.require(:contact).permit(:company, :contact_name, :location, :phone_number, :email, :industry)
    end
end
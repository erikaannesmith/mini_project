class Admin::ContactsController < Admin::BaseController

    def index
        @contacts = Contact.all
    end
    
    def new
        @admin = current_user
        @contact = Contact.new
    end

    def create
        @contact = Contact.new(contact_params)
        if @contact.save
            flash[:success] = "You created #{@contact.contact_name} at #{@contact.company}!"
            redirect_to "/"
        else
            flash[:alert] = "#{@contact.contact_name} at #{@contact.company} already exists!"            
            render :new
        end
    end

    def show
        @contact = Contact.find(params[:id])
    end

    def edit
        @contact = Contact.find(params[:id])
    end

    def update
        @contact = Contact.find(params[:id])
        @contact.update(contact_params)
        if @contact.save
            flash[:success] = "#{@contact.contact_name} updated!"
            redirect_to admin_contact_path(@contact)
        else
            redirect_to admin_contacts_path
        end
    end

    def destroy
        
    end

    private

    def contact_params
        params.require(:contact).permit(:company, :contact_name, :location, :phone_number, :email, :industry)        
    end

end
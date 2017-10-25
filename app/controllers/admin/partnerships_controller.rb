class Admin::PartnershipsController < Admin::BaseController
    
    def index
        @partnerships = Partnership.all
    end

end
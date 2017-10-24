class DesignsController < ApplicationController

  def index
    @designs = current_user.designs
  end

end

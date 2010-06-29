class AdminController < ApplicationController
  def login
    if request.post?
      rider = Rider.authenticate(params[:name], params[:password])
      if rider
        session[:rider_id] = rider.id
        redirect_to :action => 'index'
      else
        flash.now[:notice] = "Invalid user/pass combination"
      end
    end
  end

  def logout
  end

  def index
    @riders = Rider.find(:all)
  end

end

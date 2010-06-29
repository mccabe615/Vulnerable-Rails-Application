class ApplicationController < ActionController::Base
  protect_from_forgery
  layout 'application'

  # bad practice:  blacklisting is bad, whitelisting is better
  #   good = before_filter :authorize, :except => :login
  #   bad = before_filter :authorize, :only => [:edit, :delete]
  
  before_filter :authorize, :only => :edit
  helper :all
  
  # vulnerability:  below method should be protected because methods in here appear
  # as instance methods in all of the controllers
  def authorize
    unless Rider.find_by_id(session[:rider_id])
      flash[:notice] = "login"
      redirect_to :controller => 'admin', :action => 'login'
    end
  end
  
end

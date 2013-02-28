# Filters added to this controller apply to all controllers in the application.
# Likewise, all the methods added will be available for all controllers.

class ApplicationController < ActionController::Base
  
  # Serious errors will send an e-mail to sysadmin@iteks.com.tr
  include ExceptionNotifiable
  
  helper :all # include all helpers, all the time
  
  # Everything requires a logged in user.
  before_filter :login_required
  
  # See ActionController::RequestForgeryProtection for details
  # Uncomment the :secret if you're not using the cookie session store
  protect_from_forgery #:secret => '04293faa746a395741c267ce6b8440c7'
  
  # Filter users' passwords from the logs.
  filter_parameter_logging :password
  
  private
  
  def login_required
    if session[:user_id]
      @current_user = User.find(session[:user_id])
    else
      if request.request_uri != '/'
        session[:original_uri] = request.request_uri
        flash[:notice] = "Please log in to continue."
      end
      redirect_to new_session_url
    end
  end
  
  def admin_required
    if !@current_user.admin?
      flash[:error] = "You must be an administrator to do that."
      redirect_to(:controller => @current_user.home)
    end
  end
  
  def method_missing(name, *args, &block)
    if name.to_s[/^can_([^_]+)_(.+)$/]
      if !@current_user.can?($1.intern, $2.intern)
        flash[:error] = "You do not have sufficient permission to do that."
        redirect_to :controller => @current_user.home
      end
    else
      super
    end
  end
end

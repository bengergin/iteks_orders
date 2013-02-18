class SessionsController < ApplicationController
  skip_before_filter :login_required
  layout "login"
    
  def new
  end
  
  def create
    user = User.authenticate(params[:login], params[:password])
    if user
      session[:user_id] = user.id
      @current_user = user
      flash[:notice] = "Welcome back, #{user.first_name}!"
      uri = session[:original_uri]
      session[:original_uri] = nil
      redirect_to (uri || url_for(:controller => @current_user.home))
    else
      flash[:error] = "Invalid login/password combination, please try again."
      render :action => 'new'
    end
  end
  
  def destroy
    reset_session
    flash[:notice] = "You've been logged out."
    redirect_to new_session_url
  end
end

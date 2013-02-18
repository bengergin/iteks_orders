require File.dirname(__FILE__) + '/../test_helper'
require 'sessions_controller'

# Re-raise errors caught by the controller.
class SessionsController; def rescue_action(e) raise e end; end

class SessionsControllerTest < ActionController::TestCase
  def setup
    @controller = SessionsController.new
    @request    = ActionController::TestRequest.new
    @response   = ActionController::TestResponse.new
  end
  
  def test_valid_login
    post :create, {:login => users(:eren).login, :password => '8fmx2632'}
    assert_response :redirect
    assert_equal "Welcome back, Eren!", flash[:notice]
    assert_equal users(:eren).id, session[:user_id]
    assert_equal users(:eren), assigns(:current_user)
  end
  
  def test_invalid_login
    post :create, {:login => 'wooot', :password => '8fmx2632'}
    assert_template 'new'
    assert_equal "Invalid login/password combination!", flash[:error]
    assert_nil session[:user_id]
  end
  
  def test_invalid_password
    post :create, {:login => users(:eren).login, :password => 'adsasd'}
    assert_template 'new'
    assert_equal "Invalid login/password combination!", flash[:error]
    assert_nil session[:user_id]
  end
  
  def test_invalid_login_and_password
    post :create, {:login => 'asdad', :password => 'adsasd'}
    assert_template 'new'
    assert_equal "Invalid login/password combination!", flash[:error]
    assert_nil session[:user_id]
  end
end

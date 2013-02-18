require "#{File.dirname(__FILE__)}/../test_helper"

class UserStoriesTest < ActionController::IntegrationTest
  fixtures :users
  
  # Eren tries to create a new order without logging in and is redirected
  # to the login form. He then logs in using his details and is redirected
  # to the new order form.
  def test_redirected_when_not_logged_in
    get '/orders/new'
    assert_redirected_to new_session_path
    
    assert_equal '/orders/new', session[:original_uri]
    assert_nil session[:user_id]
    assert_nil assigns(:current_user)
    
    post_via_redirect '/session', { 
      :login => users(:eren).login, 
      :password => '8fmx2632' 
    }
    assert_response :success
    assert_template "new"

    assert_equal users(:eren), assigns(:current_user)
    assert_equal users(:eren).id, session[:user_id]
    assert_nil session[:original_uri]
  end
  
  # Angela tries to create a new order without logging in and is redirected
  # to the login form. She then tries to log in but makes a mistake with
  # her password. She tries again successfully and then enters a simple
  # BHS order with one pack. She then enters a single dispatch.
  def test_redirected_when_not_logged_in_and_entering_invalid_details
    get '/orders/new'
    assert_redirected_to new_session_path
    
    assert_equal '/orders/new', session[:original_uri]
    assert_nil session[:user_id]
    assert_nil assigns(:current_user)
    
    post_via_redirect '/session', {
      :login => users(:angela).login,
      :password => 'WRONG'
    }
    assert_template 'new'
    assert_equal 'Invalid login/password combination, please try again.', flash[:error]
    assert_nil session[:user_id]
    assert_nil assigns(:current_user)
    assert_equal '/orders/new', session[:original_uri]
    
    post_via_redirect '/session', {
      :login => users(:angela).login,
      :password => '9fx2007ak'
    }
    assert_response :success
    assert_template 'new'
    assert_equal users(:angela), assigns(:current_user)
    assert_equal users(:angela).id, session[:user_id]
    assert_nil session[:original_uri]
  end
  
  # Claire tries to view one of her orders without logging in. She is
  # redirected to the log in page where she enters her details and is then
  # redirected to view the order she is interested in. She then chooses
  # to create a new order and enters details for two packs and a single
  # dispatch.
  def test_viewing_an_order_when_not_logged_in_and_creating_an_order
    flunk
  end
  
  # Nikki logs in to the system and chooses to create a repeat order
  # of one of her existing orders. She then modifies the description
  # and wash care symbols before adding two dispatches.
  def test_repeating_an_order
    flunk
  end
  
  # Angela logs into the system and chooses to create a new order.  The order 
  # is created without a description.  Validation informs the user and it is then 
  # entered.  The user then fills in the disapatch and size chart information to 
  # complete the order.
  def test_create_an_order
    flunk
  end
  
  # Claire logs into the system to update a status of an order.  The order status 
  # is changed to red seal approved.  Claire then logs out of the system
  def test_update_status_of_an_order
    flunk
  end
  
  # 
end

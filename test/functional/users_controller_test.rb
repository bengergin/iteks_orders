require File.dirname(__FILE__) + '/../test_helper'
require 'users_controller'

# Re-raise errors caught by the controller.
class UsersController; def rescue_action(e) raise e end; end

class UsersControllerTest < ActionController::TestCase
  def setup
    @controller = UsersController.new
    @request    = ActionController::TestRequest.new
    @response   = ActionController::TestResponse.new
  end
  
  def test_index_with_user
    get :index, {}, {:user_id => users(:eren).id }
    assert_response :success
    assert_select "a[href=/users/new]"
  end
  
  def test_index_without_user
    get :index
    assert_redirected_to new_session_path
  end
  
  def test_new_without_user
    get :new
    assert_redirected_to new_session_path
  end
  
  def test_create_without_user
    assert_no_difference 'User.count' do
      post :create, {}
      assert_redirected_to new_session_path
    end
  end
  
  def test_updated_without_user
    put :update, {}
    assert_redirected_to new_session_path
  end
  
  def test_new_with_user
    get :new, {}, {:user_id => users(:eren).id }
    assert_template "new"
  end
  
  def test_create_when_logged_in
    assert_difference 'User.count', 1 do
      post :create, {
        :user => {
          :login => "joe.bloggs",
          :first_name => "Joe",
          :last_name => "Bloggs",
          :password => "12345",
          :password_confirmation => "12345",
          :email => "joe@fimexltd.com",     
          :google_talk => "joe.bloggs",
          :skype => "joebloggs",
          :extension => "123"
        }             
      }, {:user_id => users(:eren).id } 
      assert_redirected_to users_path
    end
  end  
  
  def test_create_without_password_when_logged_in
    assert_no_difference 'User.count' do
      post :create, {
        :user => {
          :login => "joe.bloggs",
          :first_name => "Joe",
          :last_name => "Bloggs",
          :password => "",
          :password_confirmation => "",
          :email => "joe@fimexltd.com",     
          :google_talk => "joe.bloggs",
          :skype => "joebloggs",
          :extension => "123"
        }             
      }, {:user_id => users(:eren).id } 
      assert_template "new" 
      assert assigns(:user).errors.on(:password)
    end
  end
  
  def test_update_without_password_when_logged_in
    put :update, {
      :id => users(:ben).id,
      :user => {
        :last_name => "Bloggs",
        :password => "",
        :password_confirmation => ""
      }             
    }, {:user_id => users(:eren).id } 
    assert_redirected_to users_path
    assert_equal "Bloggs", User.find(users(:ben).id).last_name 
    assert_equal users(:ben).hashed_password, User.find(users(:ben).id).hashed_password
  end
  
  def test_update_with_password_when_logged_in
    put :update, {
      :id => users(:ben).id,
      :user => {
        :password => "ABC123",
        :password_confirmation => "ABC123"
      }             
    }, {:user_id => users(:eren).id } 
    assert_redirected_to users_path
    assert_equal User.encrypted_password('ABC123', users(:ben).salt), User.find(users(:ben).id).hashed_password
  end
end    
       
require File.dirname(__FILE__) + '/../test_helper'

class TransportControllerTest < ActionController::TestCase
  def setup
    @controller = TransportsController.new
    @request    = ActionController::TestRequest.new
    @response   = ActionController::TestResponse.new
  end

  def test_index_with_user
    get :index, {}, {:user_id => users(:eren).id }
    assert_response :success
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
    assert_no_difference 'Transport.count' do
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
  
  def test_create_blank_transport_with_user
    assert_no_difference 'Transport.count' do
      post :create, {}, {:user_id => users(:eren).id }
      assert_template "new"
    end
  end
end

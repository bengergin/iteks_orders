require File.dirname(__FILE__) + '/../test_helper'
require 'size_charts_controller'

# Re-raise errors caught by the controller.
class SizeChartsController; def rescue_action(e) raise e end; end

class SizeChartsControllerTest < Test::Unit::TestCase
  def setup
    @controller = SizeChartsController.new
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
    assert_no_difference 'SizeChart.count' do
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
  
  def test_create_blank_size_chart_with_user
    assert_no_difference 'SizeChart.count' do
      post :create, {}, {:user_id => users(:eren).id }
      assert_template "new"
    end
  end
end

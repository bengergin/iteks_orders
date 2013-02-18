require File.dirname(__FILE__) + '/../test_helper'
require 'orders_controller'

# Re-raise errors caught by the controller.
class OrdersController; def rescue_action(e) raise e end; end

class OrdersControllerTest < Test::Unit::TestCase
  def setup
    @controller = OrdersController.new
    @request    = ActionController::TestRequest.new
    @response   = ActionController::TestResponse.new
  end

  def test_index_with_user
    get :index, {}, {:user_id => users(:eren).id }
    assert_response :success
    assert_select "a[href=/orders/new]"
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
    assert_no_difference 'Order.count' do
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
    
    # Test that there is only one pack.
    assert_select "fieldset.pack", 1
    
    # Test that there is a pack add on.
    assert_select "fieldset.pack > table.add_ons input"
  end
  
  def test_edit_while_logged_in
    get :edit, { :id => orders(:heatons_order_1).id }, { :user_id => users(:eren).id }
    assert_template "new"
    
    assert_select "fieldset.pack", orders(:heatons_order_1).packs.count
  end
  
  def test_create_blank_order_with_user
    assert_no_difference 'Order.count' do
      post :create, {}, {:user_id => users(:eren).id }
      assert_template "new"
    end
  end
  
  def test_create_valid_order_with_no_packs_with_user
    assert_no_difference 'Order.count' do
      post :create, {:order => { 
        :description => '5pk Boys Sport', 
        :customer => customers(:matalan),
        :department => departments(:boys),
        :season => 'A/W 08',
        :weight => 15,
        :dyed => 1,
        :yarn_count => '70/20',
        :washes => '',
        :number_of_cylinders => '',
        :gauge => '120',
        :required_tests => 'Fibre composition',
        :test_house => '',
        :goods_need_washing => false
      }, :new_pack_attributes => []}, {:user_id => users(:eren).id }
      assert_template "new"
    end
  end
  
  def test_create_valid_order_with_pack_with_user
    assert_difference 'Order.count', 1 do
      post :create, { :order => { 
        :description => '5pk Boys Sport', 
        :customer => customers(:matalan),
        :department => departments(:boys),
        :season => 'A/W 08',
        :weight => 15,
        :dyed => 1,
        :yarn_count => '70/20',
        :washes => '',
        :number_of_cylinders => '',
        :gauge => '120',
        :required_tests => 'Fibre composition',
        :test_house => '',
        :goods_need_washing => false,
        :new_pack_attributes => {
          "a" => {
            :description => 'Hungry Hippo',
            :design_reference => 'CP12454',
            :sample_reference => 'AS45234',
            :sample_comments => 'Colour different to sample',
            :fibre_composition => 'Cotton, Nylon, Lycra Elastane',
            :gross_price_gbp => '1.25',
            :gross_price_eur => '1',
            :gross_price_usd => '3'
          }
        }
      }}, { :user_id => users(:eren).id }
      assert_redirected_to new_order_dispatch_path(assigns(:order))
      assert_equal 1, assigns(:order).packs.count
      assert_equal 'Hungry Hippo', assigns(:order).packs.first.description
      assert_equal '5pk Boys Sport', assigns(:order).description
    end
  end
  
  def test_update_order_with_user
    original_description = orders(:heatons_order_1).description
    put :update, { :id => orders(:heatons_order_1).id, :order => {
      :description => 'Something Different'
    } }, { :user_id => users(:eren).id }
    assert_not_equal original_description, Order.find(orders(:heatons_order_1).id).description
  end
  
end

require File.dirname(__FILE__) + '/../test_helper'

class FactoriesControllerTest < ActionController::TestCase
  def setup
    @controller = FactoriesController.new
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
    assert_no_difference 'Factory.count' do
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
    assert_template "edit"
  end 
  
  def test_create_blank_factory_with_user
    assert_no_difference 'Factory.count' do
      post :create, {}, {:user_id => users(:eren).id }
      assert_template "edit"
    end
  end
  
  def test_create_valid_factory_with_user
    assert_no_difference 'Factory.count' do
      post :create, { 
        :name => "Joes Factory", 
        :country => countries(:turkey),
        :telephone => "01132188855",
        :fax => "0113218886",
        :address => "Fimex Ltd, Unit 4, Victoria Road, Seacroft, Leeds",
        :city => "Leeds",
        :postcode => "LS14 1PZ",
        :audited_by => "SGS, Next",
        :comments => "This is a comment",
        :current_customers => "Walmart, Marks & Spencers",
        :machine_breakdown => "40 x Single 144N Machines",
        :metal_detection => "1",
        :number_of_employees => "10000000",
        :number_of_supervisors => "99",
        :production_capacity_in_pairs => "10000",
        :rating => "4",
        :rating_comment => "Testing Sucks",
        :size => "10000",
        :total_double_cylinder_machines => "100",
        :total_flatbed_machines => "50",
        :total_single_cylinder_machines => "10",
      }, {:user_id => users(:eren).id }
      assert_template "edit"
    end
  end
  
  def test_create_invalid_factory_without_name_with_user
    assert_no_difference 'Factory.count' do
       post :create, { 
          :name => "", 
          :country => countries(:turkey),
          :telephone => "01132188855",
          :fax => "0113218886"
        }, {:user_id => users(:eren).id }
      assert_template "edit" 
      assert assigns(:factory).errors.on(:name)
    end
  end
  
  def test_create_invalid_factory_without_country_with_user
    assert_no_difference 'Factory.count' do
       post :create, { 
          :name => "Test", 
          :country => "",
          :telephone => "01132188855",
          :fax => "0113218886"
        }, {:user_id => users(:eren).id }
      assert_template "edit" 
      assert assigns(:factory).errors.on(:country)
    end
  end
  
  def test_update_factory_name_with_password_with_user
    put :update, {
      :id => factories(:varol).id,
      :factory => {
        :name => "baro"
      }             
    }, {:user_id => users(:eren).id } 
    assert_redirected_to factory_path(assigns(:factory))
    assert_equal "baro", Factory.find(factories(:varol).id).name
  end
end

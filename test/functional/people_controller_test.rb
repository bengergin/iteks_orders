require File.dirname(__FILE__) + '/../test_helper'

class PeopleControllerTest < ActionController::TestCase
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
  
  def test_updated_without_user
    put :update, {}
    assert_redirected_to new_session_path
  end
  
  def test_new_with_user
    get :new, {}, {:user_id => users(:eren).id }
    assert_template "edit"
  end 
  
  def test_create_valid_person_with_user
    assert_no_difference 'Factory.count' do
      post :create, { 
        :first_name => "Joe", 
        :last_name => "Bloggs",
        :email => "joe@company.com",
        :skype => "joe.bloggs",
        :google_talk => "joey@gmail.com",
        :extension => "211",
        :mobile => "078119020202",
        :home => "0113 2188855",
        :work => "0113 2199944",
        :address => "4 Victoria Road, Seacroft, Leeds",
        :city => "Leeds",
        :postcode => "LS14 1PZ",
        :country => countries(:turkey),
      }, {:user_id => users(:eren).id }
      assert_redirected_to person_path(assigns(:person))
    end
  end
end

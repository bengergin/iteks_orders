require File.dirname(__FILE__) + '/../test_helper'

class UserTest < ActiveSupport::TestCase
  
  def test_authenticate_with_valid_details
    assert User.authenticate(users(:eren).login, '8fmx2632')
    assert User.authenticate(users(:paul).login, '9fx2007pm')
    assert User.authenticate(users(:angela).login, '9fx2007ak')
    assert User.authenticate(users(:claire).login, '9fx2007ch')
  end
  
  def test_authenticate_with_invalid_login
    assert !User.authenticate('NOONE', '8fmx2632')
    assert !User.authenticate('asdasd', '8fmx2632')    
  end
  
  def test_authenticate_with_different_case_login
    assert !User.authenticate(users(:eren).login.upcase, '8fmx2632')
  end
  
  def test_authenticate_with_invalid_password
    assert !User.authenticate(users(:eren).login, 'WRONG')
  end
  
  def test_authenticate_with_different_case_password
    assert !User.authenticate(users(:eren).login, '8FMX2632')
  end
  
  def test_authenticate_with_invalid_login_and_password
    assert !User.authenticate('NOONE', 'WRONG')
  end
  
  def test_authenticate_with_different_case_login_and_password
    assert !User.authenticate(users(:eren).login.upcase, '8FMX2632')
  end
  
  def test_authenticate_with_blank_details
    assert !User.authenticate('', '')
    assert !User.authenticate(nil, nil)
  end
end

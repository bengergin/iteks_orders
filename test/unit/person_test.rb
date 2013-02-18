require File.dirname(__FILE__) + '/../test_helper'

class PersonTest < ActiveSupport::TestCase

  def setup
    @new_person = Person.new
  end
  
  def test_no_name
    assert_nil @new_person.name
    
    @new_person.name = ""
    assert_nil @new_person.name
    assert_nil @new_person.first_name
    assert_nil @new_person.last_name
  end
  
  def test_one_name
    @new_person.name = "Bob"
    assert_equal "Bob", @new_person.first_name
    assert_equal "Bob", @new_person.name
    assert_nil @new_person.last_name
  end
  
  def test_two_names
    @new_person.name = "Bob Monkhouse"
    assert_equal "Bob", @new_person.first_name
    assert_equal "Monkhouse", @new_person.last_name
    assert_equal "Bob Monkhouse", @new_person.name
  end
  
  def test_more_than_two_names
    @new_person.name = "John Horatio Malkovich"
    assert_equal "John", @new_person.first_name
    assert_equal "Malkovich", @new_person.last_name
    assert_equal "John Malkovich", @new_person.name
    
    @new_person.name = "Albert Armstrong Emery Nicholson Fiennes-Harrow"
    assert_equal "Albert", @new_person.first_name
    assert_equal "Fiennes-Harrow", @new_person.last_name
    assert_equal "Albert Fiennes-Harrow", @new_person.name
  end
  
  def test_no_age
    assert_nil @new_person.age
  end
  
  def test_age
    @new_person.date_of_birth = Time.local(1985, "may", 19)
    assert_equal 22, @new_person.age
  end
end

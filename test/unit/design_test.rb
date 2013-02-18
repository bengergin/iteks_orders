require File.dirname(__FILE__) + '/../test_helper'

class DesignTest < ActiveSupport::TestCase
  
  def setup
    @design = Design.new
  end
  
  def test_tag_list_with_no_tags
    assert_equal "", @design.tag_list
  end
  
  def test_tag_list
    assert_equal "Funky, Cartoon", designs(:tagged_up).tag_list
  end
  
  def test_tag_list_assignment
    @design.tag_list = "calendar, busy, fry"
    assert_equal "calendar, busy, fry", @design.tag_list
    assert_equal %w{calendar busy fry}, @design.instance_variable_get("@tag_array")
  end
  
  def test_tag_list_assignment_with_duplicates
    @design.tag_list = "calendar, calendar, calendar"
    assert_equal "calendar", @design.tag_list
    assert_equal %w{calendar}, @design.instance_variable_get("@tag_array")
  end
  
  def test_tag_names_with_no_tags
    assert_equal [], @design.tag_names
  end
  
  def test_tag_names
    assert_equal %w{Funky Cartoon}, designs(:tagged_up).tag_names
  end
  
  def test_save_tags_with_no_tags
    @new_design = designs(:untagged)
    assert_no_difference 'Tag.count' do
      @new_design.save
    end
  end
  
  def test_save_tags
    @new_design = designs(:untagged)
    assert_difference 'Tag.count', 3 do
      @new_design.tag_list = "break, talk, hammer"
      assert @new_design.save
    end
    assert_equal %w{break talk hammer}, @new_design.tag_names
    assert_equal "break, talk, hammer", @new_design.tag_list
  end
end
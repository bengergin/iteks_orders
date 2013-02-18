require File.dirname(__FILE__) + '/../test_helper'

class DispatchTest < ActiveSupport::TestCase
  
  def test_quantity_for_pack_a_order_1
    actual_quantity = dispatch_quantities(:bhs_order_1_dispatch_1_quantities_1).quantity +
                      dispatch_quantities(:bhs_order_1_dispatch_1_quantities_2).quantity
                      
    assert_equal actual_quantity, dispatches(:bhs_order_1_dispatch_1).quantity_for_pack("a")
  end
  
  def test_quantity_for_pack_b_order_1
    actual_quantity = dispatch_quantities(:bhs_order_1_dispatch_1_quantities_3).quantity
    assert_equal actual_quantity, dispatches(:bhs_order_1_dispatch_1).quantity_for_pack("b")
  end
  
  def test_zero_quantity
    assert_equal 0, dispatches(:bhs_order_1_dispatch_1).quantity_for_pack("c")
  end
end

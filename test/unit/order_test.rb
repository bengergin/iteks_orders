require File.dirname(__FILE__) + '/../test_helper'

class OrderTest < ActiveSupport::TestCase
  
  def test_total_quantity
    
    # Sum the quantities (as given by the quantity method)
    total = orders(:bhs_order_1).dispatch_quantities.inject(0) {|s,o| s + o.quantity }
    
    assert_equal total, orders(:bhs_order_1).total_quantity
  end
  
  def test_total_quantity_of_zero
    order = Order.new
    assert_equal 0, order.total_quantity
  end
  
  def test_new_with_packs_without_params
    order = Order.new_with_packs
    assert_not_nil order
    assert_equal 1, order.packs.length
    assert_equal 'a', order.packs.first.letter
    assert_equal 1, order.packs.first.pack_add_ons.length
    assert_not_nil order.packs.first.pack_add_ons.first.add_on
  end
  
  def test_new_with_packs_with_params
    order = Order.new_with_packs(:description => 'Something')
    assert_not_nil order
    assert_equal 'Something', order.description
    
    assert_equal 1, order.packs.length
    assert_equal 'a', order.packs.first.letter
    assert_equal 1, order.packs.first.pack_add_ons.length
    assert_not_nil order.packs.first.pack_add_ons.first.add_on
  end
  
  def test_new_with_packs_with_block
    order = Order.new_with_packs do |o|
      o.description = "Something Else"
      o.quantity_per_pack = 5
    end
    assert_not_nil order
    assert_equal 'Something Else', order.description
    assert_equal 5, order.quantity_per_pack
    
    assert_equal 1, order.packs.length
    assert_equal 'a', order.packs.first.letter
    assert_equal 1, order.packs.first.pack_add_ons.length
    assert_not_nil order.packs.first.pack_add_ons.first.add_on
  end
  
  def test_new_with_basic_new_pack_attributes
    order = Order.new(:new_pack_attributes => {
      :a => {
        :description => 'Pack A',
        :design_reference => 'CP12345'
      },
      :b => {
        :description => 'Pack B',
        :sample_reference => 'SP1234'
      }
    })
    assert_not_nil order
    assert_equal 2, order.packs.length
    
    sorted_packs = order.packs.sort {|a,b| a.letter <=> b.letter }
    assert_equal 'a', sorted_packs.first.letter
    assert_equal 'Pack A', sorted_packs.first.description
    assert_equal 'CP12345', sorted_packs.first.design_reference
    assert_equal 'b', sorted_packs.last.letter
    assert_equal 'Pack B', sorted_packs.last.description
    assert_equal 'SP1234', sorted_packs.last.sample_reference
  end
  
  def test_new_with_new_pack_attributes_with_add_ons
    order = Order.new(:new_pack_attributes => {
      :a => {
        :description => 'Pack A',
        :design_reference => 'CP12345',
        :new_pack_add_on_attributes => [
          { :description => 'Eyes', :reference => 'CP3Y35', :quantity => 3 },
          { :description => 'Ears', :reference => 'CP34R5', :quantity => 2 },
          { :description => 'Nose', :reference => 'CPN053', :quantity => 1 }
        ]
      },
      :b => {
        :description => 'Pack B',
        :sample_reference => 'SP1234'
      }
    })
    assert_not_nil order
    assert_equal 2, order.packs.length
    
    sorted_packs = order.packs.sort {|a,b| a.letter <=> b.letter }
    
    assert_equal 3, sorted_packs.first.pack_add_ons.length
    
    sorted_pack_add_ons = sorted_packs.first.pack_add_ons.sort {|a,b| a.quantity <=> b.quantity }
    
    assert_equal 1, sorted_pack_add_ons[0].quantity
    assert_equal 'Nose', sorted_pack_add_ons[0].description
    assert_equal 'CPN053', sorted_pack_add_ons[0].reference
    
    assert_equal 2, sorted_pack_add_ons[1].quantity
    assert_equal 'Ears', sorted_pack_add_ons[1].description
    assert_equal 'CP34R5', sorted_pack_add_ons[1].reference
    
    assert_equal 3, sorted_pack_add_ons[2].quantity
    assert_equal 'Eyes', sorted_pack_add_ons[2].description
    assert_equal 'CP3Y35', sorted_pack_add_ons[2].reference
    
    assert_equal 'a', sorted_packs.first.letter
    assert_equal 'Pack A', sorted_packs.first.description
    assert_equal 'CP12345', sorted_packs.first.design_reference
    assert_equal 'b', sorted_packs.last.letter
    assert_equal 'Pack B', sorted_packs.last.description
    assert_equal 'SP1234', sorted_packs.last.sample_reference
  end
  
  def test_new_with_new_pack_attributes_and_pack_sizes
    flunk
  end
  
  def test_new_with_new_pack_attributes_and_add_ons_and_pack_sizes
    flunk
  end
  
  def test_update_with_existing_pack_attributes
    flunk
  end
  
  def test_update_with_existing_pack_attributes_with_add_ons
    flunk
  end
  
  def test_update_with_existing_pack_attributes_with_add_ons_and_pack_sizes
    flunk
  end
  
  def test_placed_on
    flunk
  end
  
  def test_country_of_manufacture
    flunk
  end
  
  def test_factory_id
    flunk
  end
  
  def test_factory
    flunk
  end
  
  def test_how_dyed
    order = Order.new(:dyed => Order::PIECE_DYED)
    assert_equal "Piece", order.how_dyed
    
    order.dyed = Order::YARN_DYED
    assert_equal "Yarn", order.how_dyed
    
    order.dyed = nil
    assert_nil order.how_dyed
  end
end

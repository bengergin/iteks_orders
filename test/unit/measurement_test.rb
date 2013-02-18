require File.dirname(__FILE__) + '/../test_helper'

class MeasurementTest < ActiveSupport::TestCase
  
  def test_new_with_new_measurement_size_attributes
    measurement = Measurement.new(:new_measurement_size_attributes => [
      { :size => sizes(:infants_newborn), :value => 1 },
      { :size => sizes(:girls_12h_3h), :value => 2 }
    ])
    assert_equal 2, measurement.measurement_sizes.length
    
    sorted_measurement_sizes = measurement.measurement_sizes.sort {|a,b| a.value.to_i <=> b.value.to_i }
    assert_equal 1, sorted_measurement_sizes.first.value
    assert_equal 2, sorted_measurement_sizes.last.value
    assert_equal sizes(:infants_newborn).id, sorted_measurement_sizes.first.size_id
    assert_equal sizes(:girls_12h_3h).id, sorted_measurement_sizes.last.size_id
    assert sorted_measurement_sizes.first.new_record?
    assert sorted_measurement_sizes.last.new_record?
  end
  
  def test_edit_with_new_measurement_size_attributes
    measurement = measurements(:leg_length)
    assert measurement.update_attributes(:new_measurement_size_attributes => [
      { :size => sizes(:infants_newborn), :value => 1 },
      { :size => sizes(:girls_12h_3h), :value => 2 }
    ])
    assert_equal 3, measurement.measurement_sizes.length

    sorted_measurement_sizes = measurement.measurement_sizes.sort {|a,b| a.value.to_i <=> b.value.to_i }
    assert_equal 1, sorted_measurement_sizes.first.value
    assert_equal 2, sorted_measurement_sizes[1].value
    assert_equal sizes(:infants_newborn).id, sorted_measurement_sizes.first.size_id
    assert_equal sizes(:girls_12h_3h).id, sorted_measurement_sizes[1].size_id
  end
  
  def test_edit_with_existing_measurement_size_attributes
    measurement = measurements(:welt)
    assert measurement.update_attributes(:existing_measurement_size_attributes => {
      measurement_sizes(:measurement_size_1).id.to_s => {
        :size => measurement_sizes(:measurement_size_1).size, :value => 3
      },
      measurement_sizes(:measurement_size_6).id.to_s => {
        :size => measurement_sizes(:measurement_size_6).size, :value => 2
      }
    })
    assert_equal 2, measurement.measurement_sizes.length
    
    sorted_measurement_sizes = measurement.measurement_sizes.sort {|a,b| a.value.to_i <=> b.value.to_i }
    assert_equal 2, sorted_measurement_sizes.first.value
    assert_equal 3, sorted_measurement_sizes.last.value
    assert_equal measurement_sizes(:measurement_size_6).size.id, sorted_measurement_sizes.first.size_id
    assert_equal measurement_sizes(:measurement_size_1).size.id, sorted_measurement_sizes.last.size_id
    assert !sorted_measurement_sizes.first.new_record?
    assert !sorted_measurement_sizes.last.new_record?
  end
  
  def test_edit_with_new_and_existing_meaasurement_size_attributes
    measurement = measurements(:welt)
    assert measurement.update_attributes(:existing_measurement_size_attributes => {
        measurement_sizes(:measurement_size_1).id.to_s => {
          :size => measurement_sizes(:measurement_size_1).size, :value => 4
        },
        measurement_sizes(:measurement_size_6).id.to_s => {
          :size => measurement_sizes(:measurement_size_6).size, :value => 3
        }
      },
      :new_measurement_size_attributes => [
        { :size => sizes(:infants_newborn), :value => 1 },
        { :size => sizes(:girls_12h_3h), :value => 2 }
      ]
    )
    assert_equal 4, measurement.measurement_sizes.length
    
    sorted_measurement_sizes = measurement.measurement_sizes.sort {|a,b| a.value.to_i <=> b.value.to_i }
    assert_equal 1, sorted_measurement_sizes[0].value
    assert_equal 2, sorted_measurement_sizes[1].value
    assert_equal 3, sorted_measurement_sizes[2].value
    assert_equal 4, sorted_measurement_sizes[3].value
    
    assert_equal sizes(:infants_newborn).id, sorted_measurement_sizes[0].size_id
    assert_equal sizes(:girls_12h_3h).id, sorted_measurement_sizes[1].size_id
    assert_equal measurement_sizes(:measurement_size_6).size.id, sorted_measurement_sizes[2].size_id
    assert_equal measurement_sizes(:measurement_size_1).size.id, sorted_measurement_sizes[3].size_id
  end
end

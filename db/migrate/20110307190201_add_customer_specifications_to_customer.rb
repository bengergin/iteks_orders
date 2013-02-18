class AddCustomerSpecificationsToCustomer < ActiveRecord::Migration
  def self.up
    change_table(:customers) do |t|
      t.string       :no_of_red_seals
      t.string       :no_of_gold_seals
      t.string       :test_required
      t.string       :no_of_sample_for_testing
      t.string       :metal_detected
      t.string       :packaging
      t.string       :barcodes
      t.string       :carton_specifications
      t.string       :inner_bag_specifications
      t.string       :inner_bag_warning_in_black
      t.string       :pack_labels_required_on_bag
      t.string       :name_of_freight_forwarder
      t.string       :additional_freight_forwarder_information
      t.string       :additional_customer_information
      t.string       :issues_to_watch
    end
  end

  def self.down
    change_table(:customers) do |t|
      t.remove       :no_of_red_seals
      t.remove       :no_of_gold_seals
      t.remove       :test_required
      t.remove       :no_of_sample_for_testing
      t.remove       :metal_detected
      t.remove       :packaging
      t.remove       :barcodes
      t.remove       :carton_specifications
      t.remove       :inner_bag_specifications
      t.remove       :inner_bag_warning_in_black
      t.remove       :pack_labels_required_on_bag
      t.remove       :name_of_freight_forwarder
      t.remove       :additional_freight_forwarder_information
      t.remove       :additional_customer_information    end                    
  end
end

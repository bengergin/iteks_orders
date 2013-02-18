class ChangeCustomerSpecsToText < ActiveRecord::Migration
  def self.up
    change_table(:customers) do |t|
      t.change(:no_of_red_seals, :text, :limit => nil)
      t.change(:no_of_gold_seals, :text, :limit => nil)
      t.change(:test_required, :text, :limit => nil)
      t.change(:no_of_sample_for_testing, :text, :limit => nil)
      t.change(:metal_detected, :text, :limit => nil)
      t.change(:packaging, :text, :limit => nil)
      t.change(:barcodes, :text, :limit => nil)
      t.change(:carton_specifications, :text, :limit => nil)
      t.change(:inner_bag_specifications, :text, :limit => nil)
      t.change(:inner_bag_warning_in_black, :text, :limit => nil)
      t.change(:pack_labels_required_on_bag, :text, :limit => nil)
      t.change(:name_of_freight_forwarder, :text, :limit => nil)
      t.change(:additional_freight_forwarder_information, :text, :limit => nil)
      t.change(:additional_customer_information, :text, :limit => nil)
      t.change(:issues_to_watch, :text, :limit => nil)
    end
  end

  def self.down
    change_table(:customers) do |t|
      t.change(:no_of_red_seals, :text)
      t.change(:no_of_gold_seals, :text)
      t.change(:test_required, :text)
      t.change(:no_of_sample_for_testing, :text)
      t.change(:metal_detected, :text)
      t.change(:packaging, :text)
      t.change(:barcodes, :text)
      t.change(:carton_specifications, :text)
      t.change(:inner_bag_specifications, :text)
      t.change(:inner_bag_warning_in_black, :text)
      t.change(:pack_labels_required_on_bag, :text)
      t.change(:name_of_freight_forwarder, :text)
      t.change(:additional_freight_forwarder_information, :text)
      t.change(:additional_customer_information, :text)                         
      t.change(:issues_to_watch, :text)
    end
  end
end

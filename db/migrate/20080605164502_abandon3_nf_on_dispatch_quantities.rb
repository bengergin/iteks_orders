class Abandon3NfOnDispatchQuantities < ActiveRecord::Migration
  def self.up
    change_table(:dispatch_quantities) do |t|
      t.date       :red_seal_approved_on,
                   :gold_seal_approved_on,
                   :packaging_approved_on,
                   :testing_completed_on,
                   :completed_on,
                   :ex_factory_date,
                   :customer_contract_date
                   
      t.references :order,
                   :customer
                   
      t.string     :order_reference,
                   :customer_reference,
                   :order_description,
                   :warehouse_name,
                   :country_of_manufacture,
                   :factory_name,
                   :status,
                   :pack_letter,
                   :size_name,
                   :pack_description
                   
      t.integer    :dispatch_number, 
                   :lead_time_in_weeks, 
                   :size_subscript
                   
      t.integer    :quantity_in_pairs, :default => 0
      t.integer    :number_of_dispatch_quantities, :default => 1
      
      t.boolean    :has_add_ons
      
      t.change_default(:quantity, 0)
      
      t.index      :completed_on
    end
  end

  def self.down
    change_table(:dispatch_quantities) do |t|
      t.remove_references :order,
                          :customer
                          
      t.remove            :red_seal_approved_on,
                          :gold_seal_approved_on,
                          :packaging_approved_on,
                          :testing_completed_on,
                          :completed_on,
                          :ex_factory_date,
                          :customer_contract_date,
                          :dispatch_number,
                          :order_reference,
                          :customer_reference,
                          :order_description,
                          :warehouse_name,
                          :country_of_manufacture,
                          :factory_name,
                          :status,
                          :has_add_ons,
                          :pack_letter,
                          :size_name,
                          :pack_description,
                          :quantity_in_pairs,
                          :lead_time_in_weeks,
                          :number_of_dispatch_quantities,
                          :size_subscript
      
      t.change_default(:quantity, nil)
    end
  end
end

class Abandon3NfOnDispatches < ActiveRecord::Migration
  def self.up
    change_table(:dispatches) do |t|
      t.date       :red_seal_approved_on,
                   :gold_seal_approved_on, 
                   :packaging_approved_on,
                   :testing_completed_on,
                   :completed_on
      t.string     :order_reference,
                   :customer_reference,
                   :order_description,
                   :country_of_manufacture,
                   :factory_name,
                   :status
      t.boolean    :has_add_ons
      t.references :customer
      t.integer    :quantity_in_packs,
                   :quantity_in_pairs,
                   :number_of_dispatch_quantities,
                   :default => 0
      t.integer    :lead_time_in_weeks
      t.index      :completed_on
    end
  end

  def self.down
    change_table(:dispatches) do |t|
      t.remove_references :customer
      t.remove_index      :completed_on
      t.remove            :red_seal_approved_on,
                          :gold_seal_approved_on, 
                          :packaging_approved_on,
                          :testing_completed_on,
                          :completed_on,
                          :order_reference,
                          :customer_reference,
                          :order_description, 
                          :country_of_manufacture,
                          :factory_name,
                          :status,
                          :has_add_ons,
                          :quantity_in_packs,
                          :quantity_in_pairs,
                          :lead_time_in_weeks,
                          :number_of_dispatch_quantities
    end
  end
end

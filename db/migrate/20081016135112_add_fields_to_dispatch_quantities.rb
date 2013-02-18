class AddFieldsToDispatchQuantities < ActiveRecord::Migration
  def self.up
    change_table(:dispatch_quantities) do |t|
      t.string :washes
      t.string :line_number
      t.string :customer_contract_number
      t.integer :inner_carton_quantity
    end
  end

  def self.down
    t.remove :washes,
             :line_number,
             :customer_contract_number,
             :inner_carton_quantity
  end
end

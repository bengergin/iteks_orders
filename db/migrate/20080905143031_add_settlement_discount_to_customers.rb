class AddSettlementDiscountToCustomers < ActiveRecord::Migration
  def self.up
    add_column :customers, :settlement_discount, :decimal, :precision => 5, 
               :scale => 2, :default => 0
  end

  def self.down
    remove_column :customers, :settlement_discount
  end
end

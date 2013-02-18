class AddRatioToDispatchQuantity < ActiveRecord::Migration
  def self.up
    add_column :dispatch_quantities, :ratio, :integer
  end

  def self.down
    remove_column :dispatch_quantities, :ratio
  end
end

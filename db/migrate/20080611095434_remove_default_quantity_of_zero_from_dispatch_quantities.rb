class RemoveDefaultQuantityOfZeroFromDispatchQuantities < ActiveRecord::Migration
  def self.up
    change_table(:dispatch_quantities) do |t|
      t.change_default(:quantity, nil)
    end
  end

  def self.down
    change_table(:dispatch_quantities) do |t|
      t.change_default(:quantity, 0)
    end
  end
end

class AddQulityControlPassOrFailToOrders < ActiveRecord::Migration
  def self.up
    change_table(:orders) do |t|
      t.boolean       :qc
    end
  end

  def self.down
    change_table(:orders) do |t|
      t.remove       :qc
    end                    
  end
end
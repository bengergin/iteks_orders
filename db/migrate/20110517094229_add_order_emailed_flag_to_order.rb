class AddOrderEmailedFlagToOrder < ActiveRecord::Migration
  def self.up
    change_table(:orders) do |t|
      t.boolean     :order_emailed
    end
  end

  def self.down
    change_table(:orders) do |t|
      t.remove     :order_emailed
    end                    
  end
end

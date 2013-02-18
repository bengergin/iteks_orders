class AddRepeatOrderNumberToOrders < ActiveRecord::Migration
  def self.up
    change_table(:orders) do |t|
      t.integer    :repeat_number
   end 
  end

  def self.down
    change_table(:orders) do |t|
     t.remove     :repeat_number
   end
  end
end

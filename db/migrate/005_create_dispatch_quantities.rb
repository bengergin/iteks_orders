class CreateDispatchQuantities < ActiveRecord::Migration
  def self.up
    create_table :dispatch_quantities, :force => true do |t|
      t.integer     :quantity
      t.belongs_to  :dispatch
      t.belongs_to  :pack_size
      t.timestamps
    end
  end

  def self.down
    drop_table :dispatch_quantities
  end
end

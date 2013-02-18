class CreatePackAddOns < ActiveRecord::Migration
  def self.up
    create_table :pack_add_ons, :force => true do |t|
      t.belongs_to  :add_on
      t.integer     :quantity
      t.belongs_to  :pack
    end
  end

  def self.down
    drop_table :pack_add_ons
  end
end

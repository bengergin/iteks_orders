class CreateCustomers < ActiveRecord::Migration
  def self.up
    create_table :customers, :force => true do |t|
      t.string :reference
      t.string :name
    end
    add_index :customers, :reference, :unique => true
  end

  def self.down
    remove_index :customers, :reference
    drop_table :customers
  end
end

class RemoveCodeFromCustomer < ActiveRecord::Migration
  def self.up
    remove_column :customers, :code
  end

  def self.down
    add_column :customers, :code, :string
  end
end

class AddCodeToCustomer < ActiveRecord::Migration
  def self.up
    add_column :customers, :code, :string
  end

  def self.down
    remove_column :customers, :code
  end
end

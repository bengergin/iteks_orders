class AddDispatchInformationToOrders < ActiveRecord::Migration
  def self.up
    add_column :orders, :dispatch_information, :text
  end

  def self.down
    remove_column :orders, :dispatch_information
  end
end

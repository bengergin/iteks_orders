class DropShipmentsPrices < ActiveRecord::Migration
  def self.up
  	drop_table	:shipments
  	drop_table	:bill_of_ladings
  	drop_table	:invoices
  	drop_table	:purchase_orders
  	remove_column	:users, :shipments_access
  	remove_column	:users, :bill_of_lading
  	remove_column	:users, :invoice
  	remove_column	:users, :purchase_order
  	drop_table	:prices
  	drop_table	:price_statuses
  	remove_column	:users, :prices_access
  end
end

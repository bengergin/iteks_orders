class AddWarehouseIdAndWashesToDispatches < ActiveRecord::Migration
  def self.up
    change_table(:dispatches) do |t|
      t.rename :warehouse, :warehouse_name
      t.references :warehouse
      t.string :washes
    end

    Dispatch.reset_column_information
    Dispatch.all.each do |dispatch|
      dispatch.warehouse = Warehouse.find_or_create_by_name(:name => dispatch.warehouse_name, :customer_id => dispatch.customer_id)
      dispatch.washes = dispatch.order.washes
      dispatch.save
    end
  end
  
  def self.down
    change_table(:dispatches) do |t|
      t.remove :washes
      t.rename :warehouse_name, :warehouse
      t.remove_references :warehouse
    end
  end
end

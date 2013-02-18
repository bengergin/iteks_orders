class AddCustomerNameToDispatches < ActiveRecord::Migration
  def self.up
    change_table(:dispatches) do |t|
      t.string :customer_name
    end
    change_table(:dispatch_quantities) do |t|
      t.string :customer_name
    end
  end

  def self.down
    change_table(:dispatches) do |t|
      t.remove :customer_name
    end
    change_table(:dispatch_quantities) do |t|
      t.remove :customer_name
    end
  end
end

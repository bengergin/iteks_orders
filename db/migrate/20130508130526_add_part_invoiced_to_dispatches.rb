class AddPartInvoicedToDispatches < ActiveRecord::Migration
  def self.up
    change_table(:dispatches) do |t|
      t.boolean    :part_invoiced
    end
  end

  def self.down
    change_table(:dispatches) do |t|
      t.remove     :part_invoiced
    end
  end
end

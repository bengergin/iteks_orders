class AddInvoicedToDispatches < ActiveRecord::Migration
  def self.up
    change_table(:dispatches) do |t|
      t.boolean    :invoiced
    end
  end

  def self.down
    change_table(:dispatches) do |t|
      t.remove      :invoiced
    end
  end
end

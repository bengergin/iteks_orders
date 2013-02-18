class AddContractAndBillOfLadingToCustomer < ActiveRecord::Migration
  def self.up
    change_table(:users) do |t|
      t.boolean   :bill_of_lading
      t.boolean		:invoice
      t.boolean		:purchase_order
    end
  end

  def self.down
    change_table(:users) do |t|
      t.remove      :bill_of_lading
      t.remove			:invoice
      t.remove			:purchase_order
    end
  end
end

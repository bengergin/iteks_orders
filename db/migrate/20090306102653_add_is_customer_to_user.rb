class AddIsCustomerToUser < ActiveRecord::Migration
  def self.up
    change_table(:users) do |t|
      t.boolean   :is_customer
    end
  end

  def self.down
    change_table(:users) do |t|
      t.remove    :is_customer
    end
  end
end

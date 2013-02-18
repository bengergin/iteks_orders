class AddDeletedToCustomer < ActiveRecord::Migration
  def self.up
    change_table(:customers) do |t|
      t.boolean    :deleted, :default => false
    end
  end

  def self.down
    change_table(:customers) do |t|
      t.remove      :deleted
    end
  end
end

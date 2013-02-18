class AddShipmentsAccessToUsers < ActiveRecord::Migration
  def self.up
    change_table(:users) do |t|
      t.integer    :shipments_access
    end
  end

  def self.down
    change_table(:users) do |t|
      t.remove      :shipments_access
    end
  end
end

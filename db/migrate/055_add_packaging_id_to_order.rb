class AddPackagingIdToOrder < ActiveRecord::Migration
  def self.up
    add_column :orders, :packaging_id, :integer
  end

  def self.down
    remove_column :orders, :packaging_id
  end
end
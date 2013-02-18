class RemoveGroups < ActiveRecord::Migration
  def self.up
    drop_table :groups
    drop_table :groups_users
  end

  def self.down
    raise ActiveRecord::IrreversibleMigration
  end
end

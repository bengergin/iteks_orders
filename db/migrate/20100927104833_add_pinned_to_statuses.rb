class AddPinnedToStatuses < ActiveRecord::Migration
  def self.up
    add_column :statuses, :pinned, :boolean
  end

  def self.down
    remove_column :statuses, :pinned
  end
end

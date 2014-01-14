class RemovePinnedFromStatuses < ActiveRecord::Migration
	def self.up
    remove_column :statuses, :pinned
  end

  def self.down
    add_column :statuses, :pinned, :boolean
  end
end

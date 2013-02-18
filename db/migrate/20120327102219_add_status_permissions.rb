class AddStatusPermissions < ActiveRecord::Migration
  def self.up
    change_table(:users) do |t|
      t.integer    :status_access
    end
     User.update_all ["status_access = ?", 1]
  end

  def self.down
    change_table(:users) do |t|
      t.remove   :status_access
    end
  end
end

class AddReportsAccessToUsers < ActiveRecord::Migration
  def self.up
    change_table(:users) do |t|
      t.integer    :reports_access
    end
  end

  def self.down
    change_table(:users) do |t|
      t.remove      :reports_access
    end
  end
end

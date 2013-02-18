class AddDeletedToUser < ActiveRecord::Migration
  def self.up
    change_table(:users) do |t|
      t.boolean    :deleted, :default => false
    end
  end

  def self.down
    change_table(:users) do |t|
      t.remove      :deleted
    end
  end
end

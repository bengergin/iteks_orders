class AddDeletedToFactories < ActiveRecord::Migration
  def self.up
    change_table(:factories) do |t|
      t.boolean    :deleted, :default => false
    end
  end

  def self.down
    change_table(:factories) do |t|
      t.remove      :deleted
    end
  end
end

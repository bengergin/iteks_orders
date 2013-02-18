class AddQualityControlAccessToUsers < ActiveRecord::Migration
  def self.up
    change_table(:users) do |t|
      t.integer    :quality_controls_access
    end
  end

  def self.down
    change_table(:users) do |t|
      t.remove      :quality_controls_access
    end
  end
end

class AddSizeChartAccessToUsers < ActiveRecord::Migration
  def self.up
    change_table(:users) do |t|
      t.integer    :size_charts_access
    end
  end

  def self.down
    change_table(:users) do |t|
      t.remove      :size_charts_access
    end
  end
end

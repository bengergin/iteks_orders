class ChangeSamplesTable < ActiveRecord::Migration
  def self.up
    change_table(:samples) do |t|
      t.integer   :price_per
    end
    
  end

  def self.down
    change_table(:samples) do |t|
      t.remove    :price_per
    end
  end
end

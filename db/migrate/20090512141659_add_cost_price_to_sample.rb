class AddCostPriceToSample < ActiveRecord::Migration
  def self.up
    change_table(:samples) do |t|
      t.float :price
    end
  end

  def self.down
    change_table(:samples) do |t|
      t.remove :price
    end
  end
end

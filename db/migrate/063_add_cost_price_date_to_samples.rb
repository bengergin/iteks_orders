class AddCostPriceDateToSamples < ActiveRecord::Migration
  def self.up
    add_column :samples, :cost_price_date, :date
  end

  def self.down
    remove_column :samples, :cost_price_date
  end
end

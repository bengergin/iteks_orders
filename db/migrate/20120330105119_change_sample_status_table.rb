class ChangeSampleStatusTable < ActiveRecord::Migration
  def self.up
    change_table(:sample_statuses) do |t|
      t.float    "buying_price"
      t.float   "currency"
      t.integer  "price_per"
      t.integer  "exchange_rate_id",          :default => 1.0  
   end
  end

  def self.down
    change_table(:sample_statuses) do |t|
      t.remove  "buying_price"
      t.remove  "currency"
      t.remove  "price_per"
      t.remove  "exchange_rate_id",          :default => 1.0  
   end
    
  end
end

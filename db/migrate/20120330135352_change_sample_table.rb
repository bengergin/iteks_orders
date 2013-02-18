class ChangeSampleTable < ActiveRecord::Migration
  def self.up
    remove_column :samples, :price_gbp
    remove_column :samples, :price_usd
    remove_column :samples, :price_eur
    change_table(:samples) do |t|
      t.float     :currency
      t.integer   :exchange_rate_id
      t.change    (:price, :float)
    end
    
    
  end

  def self.down
    add_column :samples, :price_gbp, :integer
    add_column :samples, :price_usd, :integer
    add_column :samples, :price_eur, :integer
    change_table(:samples) do |t|
      t.remove    :currency
      t.remove    :exchange_rate_id
      t.remove    :price
    end
  end
end

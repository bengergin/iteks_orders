class AddBuyingPriceToStatuses < ActiveRecord::Migration
  def self.up
    add_column :statuses, :buying_price_gbp, :float
    add_column :statuses, :buying_price_usd, :float
    add_column :statuses, :buying_price_eur, :float
  end

  def self.down
    remove_column :statuses, :buying_price_eur
    remove_column :statuses, :buying_price_usd
    remove_column :statuses, :buying_price_gbp
  end
end

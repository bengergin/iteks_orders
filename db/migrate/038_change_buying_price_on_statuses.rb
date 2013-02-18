class ChangeBuyingPriceOnStatuses < ActiveRecord::Migration
  def self.up
    remove_column :statuses, :buying_price_eur
    remove_column :statuses, :buying_price_usd
    remove_column :statuses, :buying_price_gbp
    add_column :statuses, :buying_price, :float
    add_column :statuses, :currency, :string
    add_column :statuses, :price_per, :integer
  end

  def self.down
    add_column :statuses, :buying_price_gbp, :float
    add_column :statuses, :buying_price_usd, :float
    add_column :statuses, :buying_price_eur, :float
    remove_column :statuses, :buying_price
    remove_column :statuses, :currency
    remove_column :statuses, :price_per
  end
end

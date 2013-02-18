class AddExchangeRateToStatuses < ActiveRecord::Migration
  def self.up
    add_column :statuses, :exchange_rate, :float, :default => 1
  end

  def self.down
    remove_column :statuses, :exchange_rate
  end
end

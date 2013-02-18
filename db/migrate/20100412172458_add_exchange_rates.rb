class AddExchangeRates < ActiveRecord::Migration
  def self.up
    create_table :exchange_rates, :force => true do |t|
      t.string :name
      t.float  :rate, :default => 1
    end
  end

  def self.down
    drop_table :exchange_rates
  end
end

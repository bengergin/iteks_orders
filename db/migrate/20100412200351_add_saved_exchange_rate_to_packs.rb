class AddSavedExchangeRateToPacks < ActiveRecord::Migration
  def self.up
    change_table(:packs) do |t|
      t.float    :saved_exchange_rate
    end
  end

  def self.down
    change_table(:packs) do |t|
      t.remove    :saved_exchange_rate
    end
  end
end

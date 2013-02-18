class CreateOrdersWashCareSymbolsJoin < ActiveRecord::Migration
  def self.up
    create_table :orders_wash_care_symbols, :id => false do |t|
      t.belongs_to :order
      t.belongs_to :wash_care_symbol
    end
  end

  def self.down
    drop_table :orders_wash_care_symbols
  end
end

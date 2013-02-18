class AddHasBuyingPriceToDispatch < ActiveRecord::Migration
  def self.up
    change_table(:dispatches) do |t|
      t.boolean    :buying_price
    end
  end

  def self.down
    change_table(:dispatches) do |t|
      t.remove      :buying_price
    end
  end
end

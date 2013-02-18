class CreateSampleAddOns < ActiveRecord::Migration
  def self.up
    create_table :sample_add_ons do |t|
      t.belongs_to  :add_on
      t.integer     :quantity
      t.belongs_to  :sample
      t.decimal    :price_gbp
      t.decimal    :price_eur
      t.decimal    :price_usd
    end
  end

  def self.down
    drop_table :sample_add_ons
  end
end

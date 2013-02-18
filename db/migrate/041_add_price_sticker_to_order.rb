class AddPriceStickerToOrder < ActiveRecord::Migration
  def self.up
    add_column :orders, :price_sticker_description, :string
    add_column :orders, :price_sticker_source, :string
  end

  def self.down
    remove_column :orders, :price_sticker_source
    remove_column :orders, :price_sticker_description
  end
end

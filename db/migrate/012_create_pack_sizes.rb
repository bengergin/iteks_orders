class CreatePackSizes < ActiveRecord::Migration
  def self.up
    create_table :pack_sizes, :force => true do |t|
      t.string      :barcode_number
      t.string      :style_number
      t.string      :line_number
      t.integer     :packs_per_carton
      t.integer     :needle_number

      t.belongs_to  :size
      t.belongs_to  :pack
      t.timestamps
    end
  end

  def self.down
    drop_table :pack_sizes
  end
end

class CreateWashCareSymbols < ActiveRecord::Migration
  def self.up
    create_table :wash_care_symbols do |t|
      t.integer     :size
      t.string      :content_type
      t.string      :filename
      t.integer     :height
      t.integer     :width
      t.belongs_to  :parent
      t.string      :thumbnail
    end
  end

  def self.down
    drop_table :wash_care_symbols
  end
end

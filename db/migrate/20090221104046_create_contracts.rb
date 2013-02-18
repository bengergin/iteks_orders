class CreateContracts < ActiveRecord::Migration
  def self.up
    create_table :contracts do |t|
      t.integer     :size
      t.string      :description
      t.string      :content_type
      t.string      :filename
      t.integer     :height
      t.integer     :width
      t.belongs_to  :parent
      t.string      :thumbnail
      t.references  :order
      t.timestamps
    end
  end

  def self.down
    drop_table :contracts
  end
end

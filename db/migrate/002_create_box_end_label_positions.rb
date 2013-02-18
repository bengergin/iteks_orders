class CreateBoxEndLabelPositions < ActiveRecord::Migration
  def self.up
    create_table :box_end_label_positions, :force => true do |t|
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
    drop_table :box_end_label_positions
  end
end

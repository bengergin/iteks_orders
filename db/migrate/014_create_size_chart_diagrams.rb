class CreateSizeChartDiagrams < ActiveRecord::Migration
  def self.up
    create_table :size_chart_diagrams do |t|
      t.integer :size
      t.string  :content_type
      t.string  :filename
      t.integer :height
      t.integer :width
      t.integer :parent_id
      t.string :thumbnail
      t.belongs_to :size_chart

      t.timestamps
    end
  end

  def self.down
    drop_table :size_chart_diagrams
  end
end

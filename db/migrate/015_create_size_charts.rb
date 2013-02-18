class CreateSizeCharts < ActiveRecord::Migration
  def self.up
    create_table :size_charts do |t|
      t.boolean     :specification, :default => false
      t.integer     :inside_outside
      t.string      :description
      t.string      :additional_information
      t.float       :washing_to
      t.float       :maximum_shrinkage_length
      t.float       :maximum_shrinkage_width
      t.float       :colour_fastness
      t.float       :wet_rub
      t.float       :dry_rub
      t.belongs_to  :customer
      t.belongs_to  :department
      t.timestamps
    end
  end

  def self.down
    drop_table :size_charts
  end
end

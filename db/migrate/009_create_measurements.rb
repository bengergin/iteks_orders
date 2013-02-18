class CreateMeasurements < ActiveRecord::Migration
  def self.up
    create_table :measurements do |t|
      t.belongs_to  :size_chart
      t.string      :name
      t.integer     :number
      t.float       :tolerance
    end
  end

  def self.down
    drop_table :measurements
  end
end

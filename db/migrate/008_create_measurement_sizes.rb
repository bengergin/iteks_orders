class CreateMeasurementSizes < ActiveRecord::Migration
  def self.up
    create_table :measurement_sizes do |t|
      t.belongs_to  :measurement
      t.belongs_to  :size
      t.float       :value
    end
  end

  def self.down
    drop_table :measurement_sizes
  end
end

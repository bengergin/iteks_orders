class ChangeShrinkageMeasurementsToStrings < ActiveRecord::Migration
  def self.up
    change_column :size_charts, :maximum_shrinkage_length, :string
    change_column :size_charts, :maximum_shrinkage_width, :string
  end

  def self.down
    raise ActiveRecord::IrreversibleMigration
  end
end

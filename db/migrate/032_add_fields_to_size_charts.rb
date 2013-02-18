class AddFieldsToSizeCharts < ActiveRecord::Migration
  def self.up
    add_column :size_charts, :stability_to_wash, :string
    add_column :size_charts, :appearance_after_wash, :string
    add_column :size_charts, :colour_fastness_to_water, :string
    add_column :size_charts, :colour_fastness_to_washing, :string
    add_column :size_charts, :colour_fastness_to_perspiration, :string
    add_column :size_charts, :pull_test, :string
    remove_column :size_charts, :colour_fastness
    remove_column :size_charts, :washing_to
    rename_column :size_charts, :wet_rub, :colour_fastness_to_wet_rub
    rename_column :size_charts, :dry_rub, :colour_fastness_to_dry_rub
    change_column :size_charts, :colour_fastness_to_wet_rub, :string
    change_column :size_charts, :colour_fastness_to_dry_rub, :string
  end

  def self.down
    raise ActiveRecord::IrreversibleMigration
  end
end

class AddSeasonToDesigns < ActiveRecord::Migration
  def self.up
    add_column :designs, :season, :string
  end

  def self.down
    remove_column :designs, :season
  end
end

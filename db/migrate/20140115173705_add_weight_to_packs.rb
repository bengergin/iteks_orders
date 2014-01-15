class AddWeightToPacks < ActiveRecord::Migration
  def self.up
    add_column :packs, :weight, :string
  end

  def self.down
    remove_column :packs, :weight
  end
end

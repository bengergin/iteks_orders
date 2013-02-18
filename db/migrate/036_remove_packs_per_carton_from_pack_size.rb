class RemovePacksPerCartonFromPackSize < ActiveRecord::Migration
  def self.up
    remove_column :pack_sizes, :packs_per_carton
  end

  def self.down
    add_column :pack_sizes, :packs_per_carton, :integer
  end
end

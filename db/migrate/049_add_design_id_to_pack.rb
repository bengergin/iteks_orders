class AddDesignIdToPack < ActiveRecord::Migration
  def self.up
    add_column :packs, :design_id, :integer
  end

  def self.down
    remove_column :packs, :design_id
  end
end
class AddPackLettersToDispatches < ActiveRecord::Migration
  def self.up
    add_column :dispatches, :pack_letters, :string
  end

  def self.down
    remove_column :dispatches, :pack_letters
  end
end

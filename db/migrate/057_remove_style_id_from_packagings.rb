class RemoveStyleIdFromPackagings < ActiveRecord::Migration
  def self.up
    remove_column :packagings, :style_id
  end

  def self.down
    add_column :packagings, :style_id, :integer
  end
end

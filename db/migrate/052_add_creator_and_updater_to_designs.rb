class AddCreatorAndUpdaterToDesigns < ActiveRecord::Migration
  def self.up
    remove_column :designs, :user_id
    add_column :designs, :created_by, :integer
    add_column :designs, :updated_by, :integer
    add_index :designs, :created_by
  end

  def self.down
    remove_index :designs, :created_by
    remove_column :designs, :updated_by
    remove_column :designs, :created_by
    add_column :designs, :user_id, :integer
  end
end

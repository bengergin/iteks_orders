class AddSubscriptToSizes < ActiveRecord::Migration
  def self.up
    add_column :sizes, :subscript, :integer
  end

  def self.down
    remove_column :sizes, :subscript
  end
end

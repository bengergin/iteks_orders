class AddSubscriptToFactories < ActiveRecord::Migration
  def self.up
    add_column :factories, :subscript, :integer
  end

  def self.down
    remove_column :factories, :subscript
  end
end

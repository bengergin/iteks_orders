class CreateCustomersUsersJoin < ActiveRecord::Migration
  def self.up
    create_table :customers_users, :id => false do |t|
      t.belongs_to :customer
      t.belongs_to :user
    end
  end

  def self.down
    drop_table :customers_users
  end
end

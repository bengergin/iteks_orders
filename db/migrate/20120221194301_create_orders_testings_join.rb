class CreateOrdersTestingsJoin < ActiveRecord::Migration
  def self.up
    create_table :orders_testings, :id => false do |t|
      t.belongs_to :order
      t.belongs_to :testing
    end
  end

  def self.down
    drop_table :orders_testings
  end
end

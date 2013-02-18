class AddTesting < ActiveRecord::Migration
  def self.up
    create_table :testings, :force => true do |t|
      t.string :name
    end
  end

  def self.down
    drop_table :testings
  end
end

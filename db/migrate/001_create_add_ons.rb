class CreateAddOns < ActiveRecord::Migration
  def self.up
    create_table :add_ons, :force => true do |t|
      t.string :reference
      t.string :description
    end
  end

  def self.down
    drop_table :add_ons
  end
end

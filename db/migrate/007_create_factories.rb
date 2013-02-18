class CreateFactories < ActiveRecord::Migration
  def self.up
    create_table :factories, :force => true do |t|
      t.string :name
      t.string :country
      t.string :telephone
      t.string :fax
    end
  end

  def self.down
    drop_table :factories
  end
end

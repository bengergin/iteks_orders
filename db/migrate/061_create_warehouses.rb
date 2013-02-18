class CreateWarehouses < ActiveRecord::Migration
  def self.up
    create_table :warehouses do |t|
      t.string :name
      t.string :telephone
      t.string :fax
      t.text :address
      t.string :city
      t.string :postcode
      t.references :country
      t.references :customer

      t.timestamps
    end
  end

  def self.down
    drop_table :warehouses
  end
end

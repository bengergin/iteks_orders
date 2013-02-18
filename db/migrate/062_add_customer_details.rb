class AddCustomerDetails < ActiveRecord::Migration
  def self.up
    add_column :customers, :address, :text
    add_column :customers, :city, :string
    add_column :customers, :postcode, :string
    add_column :customers, :country_id, :integer
    add_column :customers, :telephone, :string
    add_column :customers, :fax, :string
  end

  def self.down
    remove_column :customers, :address
    remove_column :customers, :city
    remove_column :customers, :postcode
    remove_column :customers, :country
    remove_column :customers, :telephone
    remove_column :customers, :fax
  end
end
    
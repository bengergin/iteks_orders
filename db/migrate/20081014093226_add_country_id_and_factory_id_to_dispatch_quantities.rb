class AddCountryIdAndFactoryIdToDispatchQuantities < ActiveRecord::Migration
  def self.up
    change_table(:dispatch_quantities) do |t|
      t.references :country, :factory, :company
      t.index :country_id
      t.index :factory_id
      t.index :company_id
      t.rename :country_of_manufacture, :country_name
    end
  end

  def self.down
    change_table(:dispatch_quantities) do |t|
      t.rename :country_name, :country_of_manufacture, :company
      t.remove_index :company_id
      t.remove_index :factory_id
      t.remove_index :country_id
      t.remove_references :country, :factory
    end
  end
end

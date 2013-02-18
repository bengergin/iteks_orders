class AddCountryIdToFactories < ActiveRecord::Migration
  def self.up
    change_table(:factories) do |t|
      t.rename :country, :country_name
      t.integer :country_id
      t.index :country_id
    end
    
    Factory.reset_column_information
    Factory.all.each do |factory|
      factory.country_id = Country.find_by_name(factory.country_name).id
      factory.save
    end
  end

  def self.down
    change_table(:factories) do |t|
      t.rename :country_name, :country
      t.remove :country_id
      t.remove_index :country_id
    end
  end
end

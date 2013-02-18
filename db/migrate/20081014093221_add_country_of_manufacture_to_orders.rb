class AddCountryOfManufactureToOrders < ActiveRecord::Migration
  def self.up
    change_table(:orders) do |t|
      t.references :country
      t.index :country_id
    end
    
    Order.all.each do |order|
      place = order.statuses.find_by_category('placed', :order => 'created_at DESC')
      if place && place.country_of_manufacture?
        order.country = Country.find_or_create_by_name(place.country_of_manufacture)
        order.save
      end
    end
  end

  def self.down
    change_table(:orders) do |t|
      t.remove_index :country_id
      t.remove_references :country
    end
  end
end

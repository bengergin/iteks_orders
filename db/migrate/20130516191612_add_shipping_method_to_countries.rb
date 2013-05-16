class AddShippingMethodToCountries < ActiveRecord::Migration
  def self.up
    change_table(:countries) do |t|
      t.string       :shipping_method
    end
  end

  def self.down
    change_table(:countries) do |t|
      t.remove       :shipping_method
    end                    
  end
end

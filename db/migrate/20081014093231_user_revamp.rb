class UserRevamp < ActiveRecord::Migration
  def self.up
    change_table(:users) do |t|
      t.string     :home, :default => "orders"
      t.integer    :orders_access,
                   :designs_access,
                   :packagings_access,
                   :samples_access,
                   :factories_access,
                   :people_access,
                   :warehouses_access,
                   :customers_access
                   
      t.boolean    :admin,
                   :buying_price,
                   :selling_price,
                   :statistics,
                   :unplaced,
                   :default => false
    end
  end

  def self.down
    change_table(:users) do |t|
      t.remove            :home,
                          :orders_access,
                          :designs_access,
                          :packagings_access,
                          :samples_access,
                          :factories_access,
                          :people_access,
                          :warehouses_access,
                          :admin,
                          :buying_price,
                          :selling_price,
                          :statistics,
                          :customers_access,
                          :unplaced
    end
  end
end
            
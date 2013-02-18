class AddPricesAccessToUsers < ActiveRecord::Migration
  def self.up
    change_table(:users) do |t|
      t.integer    :prices_access
    end
  end

  def self.down
    change_table(:users) do |t|
      t.remove      :prices_access
    end
  end
end

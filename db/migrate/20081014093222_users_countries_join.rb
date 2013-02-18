class UsersCountriesJoin < ActiveRecord::Migration
  def self.up
    create_table(:countries_users, :id => false) do |t|
      t.references :country, :user
    end
    add_index :countries_users, :user_id
    add_index :countries_users, [ :country_id, :user_id ], :unique => true
  end

  def self.down
    drop_table(:countries_users)
  end
end

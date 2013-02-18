class CreateUsers < ActiveRecord::Migration
  def self.up
    create_table :users do |t|
      t.string :login
      t.string :first_name
      t.string :last_name
      t.string :hashed_password
      t.string :salt
      t.string :email
      t.string :skype
      t.string :google_talk
      t.string :extension
      t.string :mobile_number
    end
  end

  def self.down
    drop_table :users
  end
end

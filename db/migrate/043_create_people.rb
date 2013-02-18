class CreatePeople < ActiveRecord::Migration
  def self.up
    create_table :people do |t|
      t.string :first_name
      t.string :last_name
      t.string :email
      t.string :skype
      t.string :google_talk
      t.string :extension
      t.string :mobile
      t.string :home
      t.string :work
      t.text :address
      t.string :city
      t.string :postcode
      t.references :country

      t.timestamps
    end
  end

  def self.down
    drop_table :people
  end
end

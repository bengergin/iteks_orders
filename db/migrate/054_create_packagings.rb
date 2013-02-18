class CreatePackagings < ActiveRecord::Migration
  def self.up
    create_table :packagings do |t|
      t.belongs_to  :customer
      t.belongs_to  :department
      t.belongs_to  :style
      t.belongs_to  :original
      
      t.integer :amendment_number
      t.integer :created_by
      t.integer :updated_by
      t.string  :description
      t.text    :additional_information
      
      t.string  :thumbnail_path
      t.string  :full_description
      t.string  :reference
      t.string  :season
      
      t.boolean :taken, :default => false, :null => false
      t.timestamps
    end
    add_index :packagings, :customer_id
    add_index :packagings, :department_id
    add_index :packagings, :description
    add_index :packagings, :created_by
  end

  def self.down
    drop_table :packagings
  end
end
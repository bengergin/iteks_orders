class CreateDesigns < ActiveRecord::Migration
  def self.up
    create_table :designs do |t|
      t.belongs_to  :customer
      t.belongs_to  :department
      t.belongs_to  :style
      t.belongs_to  :user
      t.belongs_to  :original
      
      t.integer :amendment_number
      t.string  :description
      t.integer :number_of_artworks
      t.text    :additional_information
      
      t.string  :thumbnail_path
      t.string  :full_description
      t.string  :reference
      
      t.boolean :taken, :default => false, :null => false
      
      t.timestamps
    end
    add_index :designs, :customer_id
    add_index :designs, :department_id
    add_index :designs, :description
  end

  def self.down
    drop_table :designs
  end
end

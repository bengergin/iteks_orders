class CreateSampleStatuses < ActiveRecord::Migration
  def self.up
    create_table :sample_statuses do |t|
      t.references :sample, :null => false
      t.string :type
      t.date :occurred_on
      t.text :description
      t.integer :created_by, :null => false
      t.integer :updated_by, :null => false
      
      t.timestamps
    end
    add_index :sample_statuses, :sample_id
  end

  def self.down
    remove_index :sample_statuses, :sample_id
    drop_table :sample_statuses
  end
end

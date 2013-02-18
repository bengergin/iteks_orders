class CreateSamples < ActiveRecord::Migration
  def self.up
    create_table :samples do |t|
      t.references  :customer, :null => false
      t.references  :department, :null => false
      t.references  :style, :null => false
      t.references  :size_chart
      t.references  :factory
      t.references  :country
      t.references  :design
      
      t.string    :description, :null => false
      t.string    :full_description
      t.string    :fibre_composition
      t.string    :comments
      t.string    :type_of_cotton
      t.string    :backing_yarn
      t.string    :main_yarn
      t.string    :elastic_type
      
      t.decimal   :price_gbp, :precision => 6, :scale => 2
      t.decimal   :price_usd, :precision => 6, :scale => 2
      t.decimal   :price_eur, :precision => 6, :scale => 2
      
      t.boolean   :has_add_ons, :boolean, :default => false
      t.boolean   :looping_check_required
      
      t.integer   :quantity_required
      t.integer   :weight
      t.integer   :gauge
      t.integer   :number_of_cylinders
      t.integer   :number_of_needles
      t.integer   :number_of_colourways
      t.integer   :forming
      t.integer   :colour_match
      t.integer   :lycra_or_elastane
      
      t.date    :required_on
      t.date    :completed_on
      t.date    :sent_on
      
      t.integer :created_by, :null => false
      t.integer :updated_by, :null => false
      
      t.timestamps
    end
    add_index :samples, :created_by, :null => false
    add_index :samples, :customer_id
    add_index :samples, :department_id
    add_index :samples, :style_id
    add_index :samples, :completed_on
    add_index :samples, :sent_on
    
    create_table :samples_sizes, :id => false do |t|
      t.belongs_to :sample
      t.belongs_to :size
    end
    add_index :samples_sizes, [:sample_id, :size_id], :unique => true
    add_index :samples_sizes, :sample_id
  end

  def self.down
    remove_index :samples, :user_id
    remove_index :samples, :customer_id
    remove_index :samples, :department_id
    remove_index :samples, :style_id
    remove_index :samples, :completed_on
    remove_index :samples_sizes, [:sample_id, :size_id], :unique => true
    remove_index :samples_sizes, :sample_id
    drop_table :samples_sizes
    drop_table :samples
  end
end

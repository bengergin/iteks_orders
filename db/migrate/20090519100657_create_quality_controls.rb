class CreateQualityControls < ActiveRecord::Migration
  def self.up
    create_table :quality_controls do |t|
      t.date        :occurred_on
      
      t.references  :order
      t.references  :dispatch
      t.references  :customer
      t.references  :department
      
      t.belongs_to  :user
      
      t.text        :problem_description
      t.text        :action_taken
      t.text        :additional_information
      
      t.integer     :total_quantity
      t.integer     :quantity_checked
      t.integer     :major_faults
      t.integer     :minor_faults
      
      t.boolean     :packaging_colours
      t.boolean     :print_card_quality
      t.boolean     :barcode
      t.boolean     :retail_price
      t.boolean     :packaging_description
      t.boolean     :pack_quantity
      t.boolean     :wash_care_instructions
      t.boolean     :fibre_content_product_claims
      t.boolean     :inner_bag_quantity
      t.boolean     :bag_label
      t.boolean     :hook
      t.boolean     :sock_colours
      t.boolean     :sock_design
      t.boolean     :sock_sizes
      t.boolean     :sock_pack_order
      t.boolean     :yarn_knitting_quality
      t.boolean     :add_ons
      t.boolean     :inside_loops
      t.boolean     :purista
      t.boolean     :pass_fail
      
      t.timestamps
    end
  end

  def self.down
    drop_table :quality_controls
  end
end
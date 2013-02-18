class CreateOrders < ActiveRecord::Migration
  def self.up
    create_table :orders do |t|
      t.belongs_to  :customer
      t.belongs_to  :department
      t.belongs_to  :style
      t.string      :season
      t.string      :description
      t.integer     :quantity_per_pack
      t.integer     :weight
      t.belongs_to  :weight_size
      t.string      :barcode_number, :null => true
      t.string      :style_number, :null => true
      t.string      :line_number, :null => true
      t.boolean     :metal_detected
      t.boolean     :fob

      # Yarn details.
      t.integer     :dyed
      t.string      :yarn_count
      t.string      :washes
      t.string      :type_of_cotton

      # Machine Details
      t.integer     :number_of_cylinders
      t.integer     :gauge

      # Testing
      t.string      :required_tests
      t.boolean     :goods_need_washing
      t.string      :test_house

      # Packaging
      t.string      :packaging_reference
      t.integer     :quantity_per_polybag
      t.string      :packaging_type
      t.string      :packaging_colour
      t.string      :packaging_source
      t.string      :description_on_packaging
      t.string      :packaging_rrp
      t.string      :polybag_barcode_number
      t.string      :barcode_description
      t.string      :barcode_source
      t.string      :hook_type_description
      t.string      :hook_type_source
      t.string      :size_sticker_description
      t.string      :size_sticker_source
      t.boolean     :lycra_sticker
      t.string      :lycra_sticker_source
      t.string      :promo_sticker_description
      t.string      :promo_sticker_source
      t.string      :card_insert_description
      t.string      :card_insert_source
      t.string      :custom_box_description
      t.string      :custom_box_source
      t.string      :polybag_description
      t.string      :polybag_source
      t.string      :polybag_sticker_description
      t.string      :polybag_sticker_source
      t.string      :polybag_warning_description
      t.string      :box_end_label_source
      t.string      :box_end_barcode
      t.string      :box_end_barcode_source
      t.belongs_to  :box_end_label_position
      t.text        :box_end_label_description
      t.string      :packaging_finish

      # Cartons
      t.string      :minimum_carton_dimensions
      t.string      :maximum_carton_dimensions
      t.string      :specific_carton_dimensions

      t.string      :carton_details
      t.string      :carton_quality
      t.string      :maximum_weight
      t.string      :tape_type
      t.boolean     :slash_card
      t.string      :taping_instructions
      t.text        :additional_packaging_information

      t.belongs_to  :size_chart
      t.belongs_to  :user
            
      t.timestamps
    end
    add_index :orders, :customer_id
    
  end

  def self.down
    drop_table :orders
  end
end

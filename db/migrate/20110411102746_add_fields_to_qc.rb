class AddFieldsToQc < ActiveRecord::Migration
  def self.up
    change_table(:quality_controls) do |t|
      t.boolean     :box_end_label
      t.boolean     :box_end_barcode
      t.boolean     :special_carton_info
      t.boolean     :carton_size
      t.boolean     :packaging_method
    end
  end

  def self.down
    change_table(:quality_controls) do |t|
      t.remove     :box_end_label
      t.remove     :box_end_barcode
      t.remove     :special_carton_info
      t.remove     :carton_size
      t.remove     :packaging_method
    end                    
  end
end

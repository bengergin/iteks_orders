class CreatePurchaseOrders < ActiveRecord::Migration
  def self.up
    create_table :purchase_orders do |t|
      t.integer     :size
      t.string      :description
      t.string			:reference
      t.string      :content_type
      t.string      :filename
      t.integer     :height
      t.integer     :width
      t.belongs_to  :parent
      t.string      :thumbnail
      t.references  :shipment
      t.timestamps
    end
  end

  def self.down
    drop_table :purchase_orders
  end
end

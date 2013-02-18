class CreateShipments < ActiveRecord::Migration
  def self.up
    create_table :shipments do |t|
  		t.date        :occurred_on
  		t.date				:eta
      
    	t.references  :order
    	t.references  :dispatch
    	t.references  :customer
    	t.references	:transport
    	t.references	:company
    	t.references	:country

    
    	t.belongs_to  :user
      
    	t.text        :reference
    	t.text        :cost
    	t.text        :additional_information
      
    	t.integer     :total_quantity

    	t.boolean			:fob
    	t.boolean    	:purchase_order
    	t.boolean    	:invoice
    	t.boolean    	:bill_of_lading
      
    	t.timestamps
    end
  end

  def self.down
    drop_table :shipments
  end
end

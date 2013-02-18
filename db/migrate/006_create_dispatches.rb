class CreateDispatches < ActiveRecord::Migration
  def self.up
    create_table :dispatches, :force => true do |t|
      t.string      :customer_contract_number
      t.date        :customer_contract_date
      t.date        :ex_factory_date
      t.integer     :inner_carton_quantity
      t.belongs_to  :order
      t.belongs_to  :transport
      t.integer     :number
      t.string      :warehouse
      t.text        :further_information
      t.timestamps
    end
  end

  def self.down
    drop_table :dispatches
  end
end

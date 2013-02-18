class CreatePricesStatusTable < ActiveRecord::Migration
  def self.up
    

    create_table "price_statuses", :force => true do |t|
      t.text     "additional_information"
      t.date     "occurred_on"
      t.integer  "price_id"
      t.integer  "user_id"
      t.string   "category"
      t.string   "country_of_manufacture"
      t.datetime "created_at"
      t.datetime "updated_at"
      t.float    "buying_price"
      t.string   "currency"
      t.integer  "price_per"
      t.integer  "exchange_rate_id",          :default => 1.0
      t.text     "description"
      t.text     "modifications"
      t.integer  "changed_id"
      t.string   "changed_type"
      t.boolean  "pinned"
    end

    add_index "price_statuses", ["price_id"], :name => "index_price_statuses_on_price_id"
  end

  def self.down
    
        drop_table :price_status
  end
end

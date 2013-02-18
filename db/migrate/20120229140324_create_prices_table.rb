class CreatePricesTable < ActiveRecord::Migration
  def self.up
    create_table "prices", :force => true do |t|
       t.string   "name"
       t.text     "description"
       t.datetime "created_at"
       t.datetime "updated_at"
       t.integer  "country_id"
       t.integer  "company_id"
       t.string   "country_name"
       t.integer  "exchange_rate_id"
       t.integer  "created_by"
       t.integer  "updated_by"
       t.float    "price"
       t.string   "currency"
       t.integer  "price_per"
     end

     add_index "prices", ["company_id"], :name => "index_prices_on_company_id"
     add_index "prices", ["country_id"], :name => "index_prices_on_country_id"
    
    
  end

  def self.down
    
      drop_table :prices
  end
end

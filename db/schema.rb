# This file is auto-generated from the current state of the database. Instead of editing this file, 
# please use the migrations feature of Active Record to incrementally modify your database, and
# then regenerate this schema definition.
#
# Note that this schema.rb definition is the authoritative source for your database schema. If you need
# to create the application database on another system, you should be using db:schema:load, not running
# all the migrations from scratch. The latter is a flawed and unsustainable approach (the more migrations
# you'll amass, the slower it'll run and the greater likelihood for issues).
#
# It's strongly recommended to check this file into your version control system.

ActiveRecord::Schema.define(:version => 20120927113050) do

  create_table "add_ons", :force => true do |t|
    t.string "reference"
    t.string "description"
  end

  create_table "attachments", :force => true do |t|
    t.integer  "uploaded_file_id", :null => false
    t.integer  "attachable_id",    :null => false
    t.string   "attachable_type",  :null => false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "box_end_label_positions", :force => true do |t|
    t.integer "size"
    t.string  "content_type"
    t.string  "filename"
    t.integer "height"
    t.integer "width"
    t.integer "parent_id"
    t.string  "thumbnail"
  end

  create_table "companies", :force => true do |t|
    t.string "name"
  end

  add_index "companies", ["name"], :name => "index_companies_on_name"

  create_table "companies_users", :id => false, :force => true do |t|
    t.integer "company_id"
    t.integer "user_id"
  end

  add_index "companies_users", ["user_id"], :name => "index_companies_users_on_user_id"

  create_table "contracts", :force => true do |t|
    t.integer  "size"
    t.string   "description"
    t.string   "content_type"
    t.string   "filename"
    t.integer  "height"
    t.integer  "width"
    t.integer  "parent_id"
    t.string   "thumbnail"
    t.integer  "order_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "countries", :force => true do |t|
    t.string "name"
  end

  create_table "countries_users", :id => false, :force => true do |t|
    t.integer "country_id"
    t.integer "user_id"
  end

  add_index "countries_users", ["country_id", "user_id"], :name => "index_countries_users_on_country_id_and_user_id", :unique => true
  add_index "countries_users", ["user_id"], :name => "index_countries_users_on_user_id"

  create_table "customers", :force => true do |t|
    t.string  "reference"
    t.string  "name"
    t.text    "address"
    t.string  "city"
    t.string  "postcode"
    t.integer "country_id"
    t.string  "telephone"
    t.string  "fax"
    t.decimal "settlement_discount",                      :default => 0.0
    t.boolean "deleted",                                  :default => false
    t.text    "no_of_red_seals"
    t.text    "no_of_gold_seals"
    t.text    "test_required"
    t.text    "no_of_sample_for_testing"
    t.text    "metal_detected"
    t.text    "packaging"
    t.text    "barcodes"
    t.text    "carton_specifications"
    t.text    "inner_bag_specifications"
    t.text    "inner_bag_warning_in_black"
    t.text    "pack_labels_required_on_bag"
    t.text    "name_of_freight_forwarder"
    t.text    "additional_freight_forwarder_information"
    t.text    "additional_customer_information"
    t.text    "issues_to_watch"
  end

  add_index "customers", ["reference"], :name => "index_customers_on_reference", :unique => true

  create_table "customers_users", :id => false, :force => true do |t|
    t.integer "customer_id"
    t.integer "user_id"
  end

  add_index "customers_users", ["user_id"], :name => "index_customers_users_on_user_id"

  create_table "departments", :force => true do |t|
    t.string "name"
  end

  create_table "departments_users", :id => false, :force => true do |t|
    t.integer "department_id"
    t.integer "user_id"
  end

  add_index "departments_users", ["department_id", "user_id"], :name => "index_departments_users_on_department_id_and_user_id", :unique => true
  add_index "departments_users", ["user_id"], :name => "index_departments_users_on_user_id"

  create_table "designs", :force => true do |t|
    t.integer  "customer_id"
    t.integer  "department_id"
    t.integer  "style_id"
    t.integer  "original_id"
    t.integer  "amendment_number"
    t.string   "description"
    t.integer  "number_of_artworks"
    t.text     "additional_information"
    t.string   "thumbnail_path"
    t.string   "full_description"
    t.string   "reference"
    t.boolean  "taken",                  :default => false, :null => false
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "created_by"
    t.integer  "updated_by"
    t.string   "season"
  end

  add_index "designs", ["created_by"], :name => "index_designs_on_created_by"
  add_index "designs", ["customer_id"], :name => "index_designs_on_customer_id"
  add_index "designs", ["department_id"], :name => "index_designs_on_department_id"
  add_index "designs", ["description"], :name => "index_designs_on_description"

  create_table "dispatch_quantities", :force => true do |t|
    t.integer  "quantity"
    t.integer  "dispatch_id"
    t.integer  "pack_size_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "ratio"
    t.date     "red_seal_approved_on"
    t.date     "gold_seal_approved_on"
    t.date     "packaging_approved_on"
    t.date     "testing_completed_on"
    t.date     "completed_on"
    t.date     "ex_factory_date"
    t.date     "customer_contract_date"
    t.integer  "order_id"
    t.integer  "customer_id"
    t.string   "order_reference"
    t.string   "customer_reference"
    t.string   "order_description"
    t.string   "warehouse_name"
    t.string   "country_name"
    t.string   "factory_name"
    t.string   "status"
    t.string   "pack_letter"
    t.string   "size_name"
    t.string   "pack_description"
    t.integer  "dispatch_number"
    t.integer  "lead_time_in_weeks"
    t.integer  "size_subscript"
    t.integer  "quantity_in_pairs",             :default => 0
    t.integer  "number_of_dispatch_quantities", :default => 1
    t.boolean  "has_add_ons"
    t.string   "customer_name"
    t.integer  "country_id"
    t.integer  "factory_id"
    t.integer  "company_id"
    t.string   "washes"
    t.string   "line_number"
    t.string   "customer_contract_number"
    t.integer  "inner_carton_quantity"
  end

  add_index "dispatch_quantities", ["company_id"], :name => "index_dispatch_quantities_on_company_id"
  add_index "dispatch_quantities", ["completed_on"], :name => "index_dispatch_quantities_on_completed_on"
  add_index "dispatch_quantities", ["country_id"], :name => "index_dispatch_quantities_on_country_id"
  add_index "dispatch_quantities", ["dispatch_id"], :name => "index_dispatch_quantities_on_dispatch_id"
  add_index "dispatch_quantities", ["factory_id"], :name => "index_dispatch_quantities_on_factory_id"
  add_index "dispatch_quantities", ["pack_size_id"], :name => "index_dispatch_quantities_on_pack_size_id"

  create_table "dispatches", :force => true do |t|
    t.string   "customer_contract_number"
    t.date     "customer_contract_date"
    t.date     "ex_factory_date"
    t.integer  "inner_carton_quantity"
    t.integer  "order_id"
    t.integer  "transport_id"
    t.integer  "number"
    t.string   "warehouse_name"
    t.text     "further_information"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.date     "red_seal_approved_on"
    t.date     "gold_seal_approved_on"
    t.date     "packaging_approved_on"
    t.date     "testing_completed_on"
    t.date     "completed_on"
    t.string   "order_reference"
    t.string   "customer_reference"
    t.string   "order_description"
    t.string   "country_name"
    t.string   "factory_name"
    t.string   "status"
    t.boolean  "has_add_ons"
    t.integer  "customer_id"
    t.integer  "quantity_in_packs",             :default => 0
    t.integer  "quantity_in_pairs",             :default => 0
    t.integer  "number_of_dispatch_quantities", :default => 0
    t.integer  "lead_time_in_weeks"
    t.string   "customer_name"
    t.integer  "country_id"
    t.integer  "factory_id"
    t.integer  "company_id"
    t.integer  "warehouse_id"
    t.string   "washes"
    t.date     "bulk_yarn_ordered_on"
    t.date     "bulk_yarn_ordered_by"
    t.date     "bulk_yarn_arrived_on"
    t.date     "bulk_yarn_arrived_by"
    t.date     "knitting_started_on"
    t.date     "knitting_started_by"
    t.string   "pack_letters"
    t.boolean  "contract"
    t.integer  "product_id"
    t.integer  "department_id"
    t.boolean  "qc_pass"
    t.boolean  "buying_price"
    t.integer  "packs_red_sealed",              :default => 0
    t.integer  "packs_gold_sealed",             :default => 0
    t.integer  "packs_tested",                  :default => 0
    t.integer  "total_number_of_packs",         :default => 0
  end

  add_index "dispatches", ["bulk_yarn_arrived_by"], :name => "index_dispatches_on_bulk_yarn_arrived_by"
  add_index "dispatches", ["bulk_yarn_arrived_on"], :name => "index_dispatches_on_bulk_yarn_arrived_on"
  add_index "dispatches", ["company_id"], :name => "index_dispatches_on_company_id"
  add_index "dispatches", ["completed_on"], :name => "index_dispatches_on_completed_on"
  add_index "dispatches", ["country_id"], :name => "index_dispatches_on_country_id"
  add_index "dispatches", ["factory_id"], :name => "index_dispatches_on_factory_id"
  add_index "dispatches", ["knitting_started_by"], :name => "index_dispatches_on_knitting_started_by"
  add_index "dispatches", ["knitting_started_on"], :name => "index_dispatches_on_knitting_started_on"
  add_index "dispatches", ["order_id"], :name => "index_dispatches_on_order_id"

  create_table "exchange_rates", :force => true do |t|
    t.string "name"
    t.float  "rate", :default => 1.0
  end

  create_table "factories", :force => true do |t|
    t.string  "name"
    t.string  "country_name"
    t.string  "telephone"
    t.string  "fax"
    t.text    "address"
    t.string  "city"
    t.string  "postcode"
    t.string  "audited_by"
    t.text    "comments"
    t.string  "current_customers"
    t.text    "machine_breakdown"
    t.boolean "metal_detection"
    t.integer "number_of_employees"
    t.integer "number_of_supervisors"
    t.string  "production_capacity_in_pairs"
    t.integer "rating"
    t.text    "rating_comment"
    t.string  "size"
    t.integer "total_double_cylinder_machines"
    t.integer "total_flatbed_machines"
    t.integer "total_single_cylinder_machines"
    t.integer "country_id"
    t.boolean "deleted",                        :default => false
  end

  add_index "factories", ["country_id"], :name => "index_factories_on_country_id"

  create_table "measurement_sizes", :force => true do |t|
    t.integer "measurement_id"
    t.integer "size_id"
    t.float   "value"
  end

  add_index "measurement_sizes", ["measurement_id"], :name => "index_measurement_sizes_on_measurement_id"

  create_table "measurements", :force => true do |t|
    t.integer "size_chart_id"
    t.string  "name"
    t.integer "number"
    t.float   "tolerance"
  end

  add_index "measurements", ["size_chart_id"], :name => "index_measurements_on_size_chart_id"

  create_table "orders", :force => true do |t|
    t.integer  "customer_id"
    t.integer  "department_id"
    t.integer  "style_id"
    t.string   "season"
    t.string   "description"
    t.integer  "quantity_per_pack"
    t.integer  "weight"
    t.integer  "weight_size_id"
    t.string   "barcode_number"
    t.string   "style_number"
    t.string   "line_number"
    t.boolean  "metal_detected"
    t.boolean  "fob"
    t.integer  "dyed"
    t.string   "yarn_count"
    t.string   "washes"
    t.string   "type_of_cotton"
    t.integer  "number_of_cylinders"
    t.integer  "gauge"
    t.text     "required_tests"
    t.boolean  "goods_need_washing"
    t.string   "test_house"
    t.string   "packaging_reference"
    t.integer  "quantity_per_polybag"
    t.string   "packaging_type"
    t.string   "packaging_colour"
    t.string   "packaging_source"
    t.string   "description_on_packaging"
    t.string   "packaging_rrp"
    t.string   "polybag_barcode_number"
    t.string   "barcode_description"
    t.string   "barcode_source"
    t.string   "hook_type_description"
    t.string   "hook_type_source"
    t.string   "size_sticker_description"
    t.string   "size_sticker_source"
    t.boolean  "lycra_sticker"
    t.string   "lycra_sticker_source"
    t.string   "promo_sticker_description"
    t.string   "promo_sticker_source"
    t.string   "card_insert_description"
    t.string   "card_insert_source"
    t.string   "custom_box_description"
    t.string   "custom_box_source"
    t.string   "polybag_description"
    t.string   "polybag_source"
    t.string   "polybag_sticker_description"
    t.string   "polybag_sticker_source"
    t.string   "polybag_warning_description"
    t.string   "box_end_label_source"
    t.string   "box_end_barcode"
    t.string   "box_end_barcode_source"
    t.integer  "box_end_label_position_id"
    t.text     "box_end_label_description"
    t.string   "packaging_finish"
    t.string   "minimum_carton_dimensions"
    t.string   "maximum_carton_dimensions"
    t.string   "specific_carton_dimensions"
    t.string   "carton_details"
    t.string   "carton_quality"
    t.string   "maximum_weight"
    t.string   "tape_type"
    t.boolean  "slash_card"
    t.string   "taping_instructions"
    t.text     "additional_packaging_information"
    t.integer  "size_chart_id"
    t.integer  "user_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "price_sticker_description"
    t.string   "price_sticker_source"
    t.integer  "packaging_id"
    t.text     "dispatch_information"
    t.text     "additional_size_chart_information"
    t.integer  "country_id"
    t.integer  "factory_id"
    t.integer  "company_id"
    t.date     "placed_on"
    t.date     "placed_by"
    t.date     "red_seal_received_on"
    t.date     "red_seal_received_by"
    t.date     "red_seal_approved_on"
    t.date     "red_seal_approved_by"
    t.date     "gold_seal_received_on"
    t.date     "gold_seal_received_by"
    t.date     "gold_seal_approved_on"
    t.date     "gold_seal_approved_by"
    t.date     "testing_completed_on"
    t.date     "testing_completed_by"
    t.date     "bulk_yarn_ordered_on"
    t.date     "bulk_yarn_ordered_by"
    t.date     "fibre_composition_received_on"
    t.date     "fibre_composition_received_by"
    t.date     "packaging_proof_sent_on"
    t.date     "packaging_proof_sent_by"
    t.date     "packaging_approved_on"
    t.date     "packaging_approved_by"
    t.date     "bulk_yarn_arrived_on"
    t.date     "bulk_yarn_arrived_by"
    t.date     "knitting_started_on"
    t.date     "knitting_started_by"
    t.boolean  "order_emailed"
    t.text     "risk_assessment"
    t.integer  "repeat_number"
    t.boolean  "ddp"
    t.integer  "forming"
    t.text     "qc"
  end

  add_index "orders", ["bulk_yarn_arrived_by"], :name => "index_orders_on_bulk_yarn_arrived_by"
  add_index "orders", ["bulk_yarn_arrived_on"], :name => "index_orders_on_bulk_yarn_arrived_on"
  add_index "orders", ["bulk_yarn_ordered_by"], :name => "index_orders_on_bulk_yarn_ordered_by"
  add_index "orders", ["bulk_yarn_ordered_on"], :name => "index_orders_on_bulk_yarn_ordered_on"
  add_index "orders", ["company_id"], :name => "index_orders_on_company_id"
  add_index "orders", ["country_id"], :name => "index_orders_on_country_id"
  add_index "orders", ["customer_id"], :name => "index_orders_on_customer_id"
  add_index "orders", ["department_id"], :name => "index_orders_on_department_id"
  add_index "orders", ["factory_id"], :name => "index_orders_on_factory_id"
  add_index "orders", ["fibre_composition_received_by"], :name => "index_orders_on_fibre_composition_received_by"
  add_index "orders", ["fibre_composition_received_on"], :name => "index_orders_on_fibre_composition_received_on"
  add_index "orders", ["gold_seal_approved_by"], :name => "index_orders_on_gold_seal_approved_by"
  add_index "orders", ["gold_seal_approved_on"], :name => "index_orders_on_gold_seal_approved_on"
  add_index "orders", ["knitting_started_by"], :name => "index_orders_on_knitting_started_by"
  add_index "orders", ["knitting_started_on"], :name => "index_orders_on_knitting_started_on"
  add_index "orders", ["packaging_approved_by"], :name => "index_orders_on_packaging_approved_by"
  add_index "orders", ["packaging_approved_on"], :name => "index_orders_on_packaging_approved_on"
  add_index "orders", ["packaging_proof_sent_by"], :name => "index_orders_on_packaging_proof_sent_by"
  add_index "orders", ["packaging_proof_sent_on"], :name => "index_orders_on_packaging_proof_sent_on"
  add_index "orders", ["placed_by"], :name => "index_orders_on_placed_by"
  add_index "orders", ["placed_on"], :name => "index_orders_on_placed_on"
  add_index "orders", ["red_seal_approved_by"], :name => "index_orders_on_red_seal_approved_by"
  add_index "orders", ["red_seal_approved_on"], :name => "index_orders_on_red_seal_approved_on"
  add_index "orders", ["style_id"], :name => "index_orders_on_style_id"
  add_index "orders", ["testing_completed_by"], :name => "index_orders_on_testing_completed_by"
  add_index "orders", ["testing_completed_on"], :name => "index_orders_on_testing_completed_on"
  add_index "orders", ["user_id"], :name => "index_orders_on_user_id"

  create_table "orders_testings", :id => false, :force => true do |t|
    t.integer "order_id"
    t.integer "testing_id"
  end

  create_table "orders_wash_care_symbols", :id => false, :force => true do |t|
    t.integer "order_id"
    t.integer "wash_care_symbol_id"
  end

  add_index "orders_wash_care_symbols", ["order_id"], :name => "index_orders_wash_care_symbols_on_order_id"

  create_table "pack_add_ons", :force => true do |t|
    t.integer "add_on_id"
    t.integer "quantity"
    t.integer "pack_id"
  end

  add_index "pack_add_ons", ["add_on_id"], :name => "index_pack_add_ons_on_add_on_id"
  add_index "pack_add_ons", ["pack_id"], :name => "index_pack_add_ons_on_pack_id"

  create_table "pack_sizes", :force => true do |t|
    t.string   "barcode_number"
    t.string   "style_number"
    t.string   "line_number"
    t.integer  "needle_number"
    t.integer  "size_id"
    t.integer  "pack_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "pack_sizes", ["pack_id"], :name => "index_pack_sizes_on_pack_id"
  add_index "pack_sizes", ["size_id"], :name => "index_pack_sizes_on_size_id"

  create_table "packagings", :force => true do |t|
    t.integer  "customer_id"
    t.integer  "department_id"
    t.integer  "original_id"
    t.integer  "amendment_number"
    t.integer  "created_by"
    t.integer  "updated_by"
    t.string   "description"
    t.text     "additional_information"
    t.string   "thumbnail_path"
    t.string   "full_description"
    t.string   "reference"
    t.string   "season"
    t.boolean  "taken",                  :default => false, :null => false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "packagings", ["created_by"], :name => "index_packagings_on_created_by"
  add_index "packagings", ["customer_id"], :name => "index_packagings_on_customer_id"
  add_index "packagings", ["department_id"], :name => "index_packagings_on_department_id"
  add_index "packagings", ["description"], :name => "index_packagings_on_description"

  create_table "packs", :force => true do |t|
    t.string   "description"
    t.string   "design_reference"
    t.string   "sample_reference"
    t.text     "sample_comments"
    t.string   "fibre_composition"
    t.float    "buying_price_gbp"
    t.float    "buying_price_eur"
    t.float    "buying_price_usd"
    t.float    "gross_price_gbp"
    t.float    "gross_price_eur"
    t.float    "gross_price_usd"
    t.string   "letter",                        :limit => 1,                               :default => "A", :null => false
    t.integer  "order_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "design_id"
    t.date     "red_seal_approved_on"
    t.date     "gold_seal_approved_on"
    t.date     "fibre_composition_received_on"
    t.date     "testing_completed_on"
    t.string   "currency"
    t.decimal  "buying_price",                               :precision => 8, :scale => 3
    t.decimal  "exchange_rate",                              :precision => 8, :scale => 3
    t.float    "saved_exchange_rate"
    t.float    "target_price"
    t.string   "selling_info"
  end

  add_index "packs", ["fibre_composition_received_on"], :name => "index_packs_on_fibre_composition_received_on"
  add_index "packs", ["gold_seal_approved_on"], :name => "index_packs_on_gold_seal_approved_on"
  add_index "packs", ["order_id"], :name => "index_packs_on_order_id"
  add_index "packs", ["red_seal_approved_on"], :name => "index_packs_on_red_seal_approved_on"
  add_index "packs", ["testing_completed_on"], :name => "index_packs_on_testing_completed_on"

  create_table "people", :force => true do |t|
    t.string   "first_name"
    t.string   "last_name"
    t.string   "email"
    t.string   "skype"
    t.string   "google_talk"
    t.string   "extension"
    t.string   "mobile"
    t.string   "home"
    t.string   "work"
    t.text     "address"
    t.string   "city"
    t.string   "postcode"
    t.integer  "country_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "products", :force => true do |t|
    t.string "name"
  end

  create_table "quality_controls", :force => true do |t|
    t.date     "occurred_on"
    t.integer  "order_id"
    t.integer  "dispatch_id"
    t.integer  "customer_id"
    t.integer  "department_id"
    t.integer  "user_id"
    t.text     "problem_description"
    t.text     "action_taken"
    t.text     "additional_information"
    t.integer  "total_quantity"
    t.integer  "quantity_checked"
    t.integer  "major_faults"
    t.integer  "minor_faults"
    t.boolean  "packaging_colours"
    t.boolean  "print_card_quality"
    t.boolean  "barcode"
    t.boolean  "retail_price"
    t.boolean  "packaging_description"
    t.boolean  "pack_quantity"
    t.boolean  "wash_care_instructions"
    t.boolean  "fibre_content_product_claims"
    t.boolean  "inner_bag_quantity"
    t.boolean  "bag_label"
    t.boolean  "hook"
    t.boolean  "sock_colours"
    t.boolean  "sock_design"
    t.boolean  "sock_sizes"
    t.boolean  "sock_pack_order"
    t.boolean  "yarn_knitting_quality"
    t.boolean  "add_ons"
    t.boolean  "inside_loops"
    t.boolean  "purista"
    t.boolean  "pass_fail"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.boolean  "box_end_label"
    t.boolean  "box_end_barcode"
    t.boolean  "special_carton_info"
    t.boolean  "carton_size"
    t.boolean  "packaging_method"
    t.boolean  "metal_detect"
    t.boolean  "email_sent"
  end

  create_table "roles", :force => true do |t|
    t.integer  "person_id"
    t.integer  "company_id"
    t.string   "company_type"
    t.string   "title"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "roles", ["company_id", "company_type"], :name => "index_roles_on_company_id_and_company_type"
  add_index "roles", ["person_id"], :name => "index_roles_on_person_id"

  create_table "sample_add_ons", :force => true do |t|
    t.integer "add_on_id"
    t.integer "quantity"
    t.integer "sample_id"
    t.decimal "price_gbp"
    t.decimal "price_eur"
    t.decimal "price_usd"
  end

  create_table "sample_statuses", :force => true do |t|
    t.integer  "sample_id",                       :null => false
    t.string   "type"
    t.date     "occurred_on"
    t.text     "description"
    t.integer  "created_by",                      :null => false
    t.integer  "updated_by",                      :null => false
    t.datetime "created_at"
    t.datetime "updated_at"
    t.float    "buying_price"
    t.float    "currency"
    t.integer  "price_per"
    t.integer  "exchange_rate_id", :default => 1
  end

  add_index "sample_statuses", ["sample_id"], :name => "index_sample_statuses_on_sample_id"

  create_table "samples", :force => true do |t|
    t.integer  "customer_id",                                              :null => false
    t.integer  "department_id",                                            :null => false
    t.integer  "style_id",                                                 :null => false
    t.integer  "size_chart_id"
    t.integer  "factory_id"
    t.integer  "country_id"
    t.integer  "design_id"
    t.string   "description",                                              :null => false
    t.string   "full_description"
    t.string   "fibre_composition"
    t.text     "comments",               :limit => 255
    t.string   "type_of_cotton"
    t.string   "backing_yarn"
    t.string   "main_yarn"
    t.string   "elastic_type"
    t.boolean  "has_add_ons",                           :default => false
    t.boolean  "boolean",                               :default => false
    t.boolean  "looping_check_required"
    t.integer  "quantity_required"
    t.integer  "weight"
    t.integer  "gauge"
    t.integer  "number_of_cylinders"
    t.integer  "number_of_needles"
    t.integer  "number_of_colourways"
    t.integer  "forming"
    t.integer  "colour_match"
    t.integer  "lycra_or_elastane"
    t.date     "required_on"
    t.date     "completed_on"
    t.date     "sent_on"
    t.integer  "created_by",                                               :null => false
    t.integer  "updated_by",                                               :null => false
    t.datetime "created_at"
    t.datetime "updated_at"
    t.date     "cost_price_date"
    t.integer  "company_id"
    t.float    "price"                  
    t.float    "currency"
    t.integer  "exchange_rate_id"
    t.integer  "price_per"
  end

  add_index "samples", ["company_id"], :name => "index_samples_on_company_id"
  add_index "samples", ["completed_on"], :name => "index_samples_on_completed_on"
  add_index "samples", ["created_by"], :name => "index_samples_on_created_by"
  add_index "samples", ["customer_id"], :name => "index_samples_on_customer_id"
  add_index "samples", ["department_id"], :name => "index_samples_on_department_id"
  add_index "samples", ["sent_on"], :name => "index_samples_on_sent_on"
  add_index "samples", ["style_id"], :name => "index_samples_on_style_id"

  create_table "samples_sizes", :id => false, :force => true do |t|
    t.integer "sample_id"
    t.integer "size_id"
  end

  add_index "samples_sizes", ["sample_id", "size_id"], :name => "index_samples_sizes_on_sample_id_and_size_id", :unique => true
  add_index "samples_sizes", ["sample_id"], :name => "index_samples_sizes_on_sample_id"

  create_table "sessions", :force => true do |t|
    t.string   "session_id", :null => false
    t.text     "data"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "sessions", ["session_id"], :name => "index_sessions_on_session_id"
  add_index "sessions", ["updated_at"], :name => "index_sessions_on_updated_at"

  create_table "size_chart_diagrams", :force => true do |t|
    t.integer  "size"
    t.string   "content_type"
    t.string   "filename"
    t.integer  "height"
    t.integer  "width"
    t.integer  "parent_id"
    t.string   "thumbnail"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "size_charts", :force => true do |t|
    t.boolean  "specification",                   :default => false
    t.integer  "inside_outside"
    t.string   "description"
    t.string   "additional_information"
    t.string   "maximum_shrinkage_length"
    t.string   "maximum_shrinkage_width"
    t.string   "colour_fastness_to_wet_rub"
    t.string   "colour_fastness_to_dry_rub"
    t.integer  "customer_id"
    t.integer  "department_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "size_chart_diagram_id"
    t.string   "stability_to_wash"
    t.string   "appearance_after_wash"
    t.string   "colour_fastness_to_water"
    t.string   "colour_fastness_to_washing"
    t.string   "colour_fastness_to_perspiration"
    t.string   "pull_test"
  end

  add_index "size_charts", ["customer_id", "department_id"], :name => "index_size_charts_on_customer_id_and_department_id"
  add_index "size_charts", ["customer_id"], :name => "index_size_charts_on_customer_id"
  add_index "size_charts", ["specification"], :name => "index_size_charts_on_specification"

  create_table "sizes", :force => true do |t|
    t.string   "name"
    t.integer  "department_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "subscript"
  end

  add_index "sizes", ["department_id"], :name => "index_sizes_on_department_id"

  create_table "statuses", :force => true do |t|
    t.text     "additional_information"
    t.date     "occurred_on"
    t.integer  "order_id"
    t.integer  "user_id"
    t.string   "category"
    t.string   "country_of_manufacture"
    t.integer  "factory_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.float    "buying_price"
    t.string   "currency"
    t.integer  "price_per"
    t.float    "exchange_rate",          :default => 1.0
    t.text     "description"
    t.text     "modifications"
    t.integer  "changed_id"
    t.string   "changed_type"
    t.boolean  "pinned"
    t.boolean  "qc"
  end

  add_index "statuses", ["order_id"], :name => "index_statuses_on_order_id"

  create_table "styles", :force => true do |t|
    t.string  "name"
    t.integer "product_id"
    t.string  "tariff_code"
  end

  create_table "taggings", :force => true do |t|
    t.integer  "tag_id",        :null => false
    t.integer  "taggable_id",   :null => false
    t.string   "taggable_type", :null => false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "taggings", ["tag_id"], :name => "index_taggings_on_tag_id"
  add_index "taggings", ["taggable_id", "taggable_type"], :name => "index_taggings_on_taggable_id_and_taggable_type"

  create_table "tags", :force => true do |t|
    t.string "name", :null => false
  end

  add_index "tags", ["name"], :name => "index_tags_on_name", :unique => true

  create_table "testings", :force => true do |t|
    t.string "name"
  end

  create_table "transports", :force => true do |t|
    t.string "name"
  end

  create_table "uploaded_files", :force => true do |t|
    t.integer  "size"
    t.string   "description"
    t.string   "content_type"
    t.string   "filename"
    t.integer  "height"
    t.integer  "width"
    t.integer  "parent_id"
    t.string   "thumbnail"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.boolean  "add_to_pdf"
  end

  create_table "users", :force => true do |t|
    t.string  "login"
    t.string  "first_name"
    t.string  "last_name"
    t.string  "hashed_password"
    t.string  "salt"
    t.string  "email"
    t.string  "skype"
    t.string  "google_talk"
    t.string  "extension"
    t.string  "mobile_number"
    t.boolean "enabled",                 :default => true
    t.string  "home",                    :default => "orders"
    t.integer "orders_access"
    t.integer "designs_access"
    t.integer "packagings_access"
    t.integer "samples_access"
    t.integer "factories_access"
    t.integer "people_access"
    t.integer "warehouses_access"
    t.integer "customers_access"
    t.boolean "admin",                   :default => false
    t.boolean "buying_price",            :default => false
    t.boolean "selling_price",           :default => false
    t.boolean "statistics",              :default => false
    t.boolean "unplaced",                :default => false
    t.integer "size_charts_access"
    t.boolean "contract_date"
    t.boolean "contract"
    t.boolean "is_customer"
    t.integer "quality_controls_access"
    t.boolean "deleted",                 :default => false
    t.integer "reports_access"
    t.integer "status_access"
  end

  add_index "users", ["enabled"], :name => "index_users_on_enabled"
  add_index "users", ["login"], :name => "index_users_on_login"

  create_table "warehouses", :force => true do |t|
    t.string   "name"
    t.string   "telephone"
    t.string   "fax"
    t.text     "address"
    t.string   "city"
    t.string   "postcode"
    t.integer  "country_id"
    t.integer  "customer_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "wash_care_symbols", :force => true do |t|
    t.integer "size"
    t.string  "content_type"
    t.string  "filename"
    t.integer "height"
    t.integer "width"
    t.integer "parent_id"
    t.string  "thumbnail"
  end

end

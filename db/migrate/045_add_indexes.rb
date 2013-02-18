class AddIndexes < ActiveRecord::Migration
  def self.up
    add_index :companies, :name
    add_index :companies_users, :user_id
    add_index :customers_users, :user_id
    add_index :dispatch_quantities, :dispatch_id
    add_index :dispatch_quantities, :pack_size_id
    add_index :dispatches, :order_id
    add_index :measurement_sizes, :measurement_id
    add_index :measurements, :size_chart_id
    add_index :orders, :department_id
    add_index :orders, :style_id
    add_index :orders, :user_id
    add_index :orders_wash_care_symbols, :order_id
    add_index :pack_add_ons, :pack_id
    add_index :pack_add_ons, :add_on_id
    add_index :pack_sizes, :pack_id
    add_index :pack_sizes, :size_id
    add_index :packs, :order_id
    add_index :roles, :person_id
    add_index :roles, [:company_id, :company_type]
    add_index :size_charts, :specification
    add_index :size_charts, :customer_id
    add_index :size_charts, [:customer_id, :department_id]
    add_index :sizes, :department_id
    add_index :statuses, :order_id
    add_index :users, :login
  end

  def self.down
    remove_index :companies, :name
    remove_index :companies_users, :user_id
    remove_index :customers_users, :user_id
    remove_index :dispatch_quantities, :dispatch_id
    remove_index :dispatch_quantities, :pack_size_id
    remove_index :dispatches, :order_id
    remove_index :measurement_sizes, :measurement_id
    remove_index :measurements, :size_chart_id
    remove_index :orders, :department_id
    remove_index :orders, :style_id
    remove_index :orders, :user_id
    remove_index :orders_wash_care_symbols, :order_id
    remove_index :pack_add_ons, :pack_id
    remove_index :pack_add_ons, :add_on_id
    remove_index :pack_sizes, :pack_id
    remove_index :pack_sizes, :size_id
    remove_index :packs, :order_id
    remove_index :roles, :person_id
    remove_index :roles, [:company_id, :company_type]
    remove_index :size_charts, :specification
    remove_index :size_charts, :customer_id
    remove_index :size_charts, [:customer_id, :department_id]
    remove_index :sizes, :department_id
    remove_index :statuses, :order_id
    remove_index :users, :login
  end
end
